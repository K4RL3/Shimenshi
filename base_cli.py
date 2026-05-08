"""
Puente Shimeji ↔ LM Studio
===========================
Este script actúa como intermediario entre la app Shimeji (que crea peticiones en Firestore)
y LM Studio (modelo de lenguaje local). Su flujo es:
1. Vigila continuamente la colección 'peticiones' en Firestore, buscando documentos en estado 'creacion'.
2. Para cada petición pendiente, extrae el contexto del personaje y el mensaje del usuario.
3. Construye un prompt de sistema que refleja el perfil del personaje y solicita una respuesta en JSON estructurado.
4. Envía la solicitud al endpoint de chat de LM Studio y recibe la respuesta generada por la IA.
5. Interpreta el JSON devuelto: diálogo respuesta, animación opcional y posible comando a ejecutar.
6. Actualiza el documento en Firestore con estado 'resultado', la respuesta, la animación y el comando; de esta forma, la app
   detecta que el procesamiento ha finalizado y puede mostrar la respuesta al usuario.
"""

import time
import json
import uuid
import logging
import requests
import firebase_admin
from firebase_admin import credentials, firestore

# ------------------------------------------------------------------------------------
# Configuración
# ------------------------------------------------------------------------------------
RUTA_CREDENCIALES = "shimenshi_bbd.json"   # Servicio de Firebase
COLECCION_PETICIONES = "peticiones"                          # Colección en Firestore
URL_LM_STUDIO = "http://localhost:1234/v1/chat/completions"  # Endpoint de LM Studio
MODELO_LM = "llama-3.1-8b-lexi-uncensored-v2"                                    # Nombre del modelo cargado
REINTENTOS_MAXIMOS = 2
INTERVALO_CONSULTA = 5                                       # Segundos entre barridos

# ------------------------------------------------------------------------------------
# Inicialización
# ------------------------------------------------------------------------------------
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger("puente_lmstudio")

# Iniciar Firebase Admin
credenciales = credentials.Certificate(RUTA_CREDENCIALES)
firebase_admin.initialize_app(credenciales)
base_de_datos = firestore.client()

# ------------------------------------------------------------------------------------
# Funciones auxiliares
# ------------------------------------------------------------------------------------
def construir_instrucciones_sistema(contexto: dict) -> str:
    """
    Arma el mensaje de sistema que define la personalidad, historia y estado del
    personaje, e instruye a la IA a responder únicamente con un JSON estructurado.
    """
    historia = contexto.get("historia", "")
    personalidad = contexto.get("personalidad", "")
    estado_emocional = contexto.get("estado_emocional", "")
    acciones = ", ".join(contexto.get("acciones_disponibles", []))
    estados = ", ".join(contexto.get("estados_disponibles", []))

    instrucciones = (
        f"Eres un personaje virtual con las siguientes características:\n"
        f"Historia: {historia}\n"
        f"Personalidad: {personalidad}\n"
        f"Estado emocional actual: {estado_emocional}\n"
        f"Acciones disponibles (puedes sugerir activarlas): {acciones}\n"
        f"Estados disponibles: {estados}\n\n"
        f"Responde al usuario siendo fiel a tu personalidad e historia.\n"
        f"Tu respuesta debe ser EXCLUSIVAMENTE un objeto JSON válido con esta estructura:\n"
        f'{{"respuesta": "tu diálogo aquí", "animacion": "nombre o null", '
        f'"comando": {{"tipo": "activar_animacion o activar_pantalla", "carga_util": "información extra"}} o null}}\n'
        f"Si no es pertinente, asigna null a los campos 'animacion' y 'comando'.\n"
        f"Responde solo con el JSON, sin texto adicional."
    )
    return instrucciones

def consultar_modelo(instrucciones_sistema: str, mensaje_usuario: str) -> dict:
    """
    Llama a LM Studio y traduce la respuesta a un diccionario con las claves:
    'respuesta', 'animacion' y 'comando'. Incluye reintentos si falla.
    """
    encabezados = {"Content-Type": "application/json"}
    carga_util = {
        "model": MODELO_LM,
        "messages": [
            {"role": "system", "content": instrucciones_sistema},
            {"role": "user", "content": mensaje_usuario}
        ],
        "temperature": 0.7,
        "max_tokens": 500,
        "stream": False
    }

    for intento in range(1, REINTENTOS_MAXIMOS + 1):
        try:
            respuesta_http = requests.post(URL_LM_STUDIO,
                                           headers=encabezados,
                                           json=carga_util,
                                           timeout=30)
            respuesta_http.raise_for_status()
            datos = respuesta_http.json()
            texto_generado = datos["choices"][0]["message"]["content"]
            logger.info(f"Texto crudo del modelo: {texto_generado}")

            # Buscar el bloque JSON dentro de la respuesta (por si hay texto extra)
            inicio = texto_generado.find('{')
            fin = texto_generado.rfind('}')
            if inicio == -1 or fin == -1:
                raise ValueError("No se encontró un objeto JSON en la respuesta.")
            json_limpio = texto_generado[inicio:fin+1]
            return json.loads(json_limpio)

        except Exception as error:
            logger.error(f"Intento {intento}/{REINTENTOS_MAXIMOS} fallido: {error}")
            time.sleep(1)

    # Si todos los intentos fallan, devolvemos una respuesta genérica
    return {
        "respuesta": "Lo siento, no pude procesar tu mensaje en este momento.",
        "animacion": None,
        "comando": None
    }

def construir_comando_si_valido(datos_comando: dict) -> dict | None:
    """
    Toma el diccionario del comando devuelto por la IA y lo convierte en la estructura
    que espera la app (con id único), siempre que el tipo sea válido.
    """
    if not datos_comando or not isinstance(datos_comando, dict):
        return None

    tipo = datos_comando.get("tipo")
    carga = datos_comando.get("carga_util", "")
    if tipo in ("activar_animacion", "activar_pantalla"):
        return {
            "id": str(uuid.uuid4()),
            "tipo": tipo,
            "carga_util": str(carga)
        }
    else:
        logger.warning(f"Tipo de comando desconocido: {tipo}. Se descartará.")
        return None

# ------------------------------------------------------------------------------------
# Procesamiento de una petición individual
# ------------------------------------------------------------------------------------
def procesar_peticion(documento_referencia, datos_peticion: dict):
    """
    Orquesta el procesamiento de una sola petición:
    1. Arma el prompt de sistema.
    2. Llama a LM Studio.
    3. Valida y estructura la respuesta.
    4. Actualiza el documento en Firestore al estado 'resultado'.
    """
    id_peticion = datos_peticion.get("id", "DESCONOCIDO")
    logger.info(f"⚙️  Procesando petición {id_peticion}...")

    contexto = datos_peticion.get("contexto", {})
    mensaje_original = datos_peticion.get("mensaje", "")

    # 1. Preparar instrucciones
    prompt_sistema = construir_instrucciones_sistema(contexto)

    # 2. Invocar al modelo
    resultado_ia = consultar_modelo(prompt_sistema, mensaje_original)

    # 3. Extraer y limpiar campos
    texto_respuesta = resultado_ia.get("respuesta", "")
    nombre_animacion = resultado_ia.get("animacion")
    comando_crudo = resultado_ia.get("comando")

    comando_estructurado = construir_comando_si_valido(comando_crudo)

    # 4. Preparar los campos a actualizar en Firestore
    actualizacion = {
        "estado": "resultado",
        "respuesta": texto_respuesta,
    }

    # Si hay animación la guardamos, si no, eliminamos el campo (o lo dejamos null)
    if nombre_animacion:
        actualizacion["animacion"] = nombre_animacion
    else:
        actualizacion["animacion"] = None   # O firestore.DELETE_FIELD según preferencia

    if comando_estructurado:
        actualizacion["comando_a_ejecutar"] = comando_estructurado
    else:
        actualizacion["comando_a_ejecutar"] = None

    # 5. Reflejar los cambios en Firestore
    try:
        documento_referencia.update(actualizacion)
        logger.info(f"✅ Petición {id_peticion} completada y actualizada.")
    except Exception as error:
        logger.error(f"❌ Error al actualizar petición {id_peticion}: {error}")

# ------------------------------------------------------------------------------------
# Bucle principal del puente
# ------------------------------------------------------------------------------------
def puente():
    """
    Función principal que ejecuta el bucle infinito:
    consulta Firestore en busca de peticiones nuevas y las va procesando.
    """
    logger.info("🌉 Puente Shimeji ↔ LM Studio iniciado. Esperando peticiones...")
    while True:
        try:
            # Obtener hasta 10 peticiones en estado 'creacion'
            documentos = base_de_datos.collection(COLECCION_PETICIONES)\
                                     .where("estado", "==", "creacion")\
                                     .limit(10)\
                                     .stream()

            for doc in documentos:
                datos = doc.to_dict()
                if not datos:
                    continue
                procesar_peticion(doc.reference, datos)

        except Exception as error:
            logger.error(f"Error en el bucle de vigilancia: {error}")

        time.sleep(INTERVALO_CONSULTA)

# ------------------------------------------------------------------------------------
# Punto de entrada
# ------------------------------------------------------------------------------------
if __name__ == "__main__":
    puente()
