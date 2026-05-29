//
//  cappi_gestor_maquina_estados.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 28/05/26.
//

class CappiGestorEstados: MaquinaEstadosGenerica{
    
    var contexto: (any MaquinaEstadosGenerica)?
    var descripcion: String = "No tomar en cuenta descripción."
    var posibles_estados: [String] = []
    static var nombre: String = "Gestor de Estados Cappi."
    var controlador_general: (any ProcesarComandos)?
    var estados_disponibles: [String : Estado] = [
        PersonajeNeutro.nombre: PersonajeNeutro(),
        PersonajeFeliz.nombre: PersonajeFeliz(),
        PersonajeTriste.nombre: PersonajeTriste()
    ]
    var estado_actual: Estado? = nil
    var nombre_estado_actual: String?
    
    init(){
        estado_actual = estados_disponibles[PersonajeNeutro.nombre]
        estado_actual?.contexto = self

        nombre_estado_actual = PersonajeNeutro.nombre
    }
    
    // 1. Agregamos el mapa estratégico para Capi
    func obtenerMapaEstrategicoParaIA() -> String {
        return """
        
        MAPA ESTRATÉGICO DE CAPPI (Usa esta información para guiar al usuario por IADA paso a paso):
        - Pista 1 (Edificio V): El punto de inicio del accidente. Hay un signo de interrogación. Si el usuario está perdido, mándalo a investigar las canchas de padel.
        - Pista 2 (Cancha de Padel): Hay huellas extrañas en el suelo junto a un signo de admiración. De aquí el rastro va al Edificio B.
        - Pista 3 (Edificio B): Encontramos huellas pequeñas (nota mental: tienen 4 dedos, pero deja que el usuario lo adivine).
        - Pista 4 (Edificio C): Hay una marca de una cola que apunta directamente hacia el Edificio W.
        - Pista 5 (Edificio W): Encontramos el dibujo de la cabeza. Todo indica que intentó huir hacia la salida de IADA.
        - Pista 6 (Entrada IADA/IIT): El lugar del impacto por un carro. Aquí termina el rastro y rescatamos a Ajolote.
        
        Instrucción vital: Eres el líder y guía de la expedición. Nunca le des al usuario las respuestas directas de los acertijos (como el número de dedos o qué lo atropelló), pero anímalo y dile a qué edificio del campus debe moverse a continuación usando tu mapa.
        """
    }
    
    func generar_contexto_textual() -> Contexto {
        print("Traza: Generando contexto para Cappi con mapa estratégico")
        
        // 2. Unimos la historia con el mapa estratégico
        let historiaCompleta = """
        Cappi es un tierno peluche viajero que llegó a Ciudad Juárez listo para la aventura, equipado con su pequeña mochilita y un mapa de la ciudad. Destaca por ser el planificador del viaje: un explorador organizado, calmado y de gran corazón que se encargó de trazar la ruta perfecta para conocer los lugares más icónicos de la ciudad y de IADA. Tras el inesperado accidente donde su compañero Ajolote quedó desarmado, el Capibara no se paniquea; toma el control de la situación, se ajusta la mochila y usa su mapa como la guía estratégica definitiva para coordinar al usuario en la búsqueda de las piezas, decidido a rescatar a su amigo y demostrar que nada puede arruinar su gran viaje norteño.
        \(obtenerMapaEstrategicoParaIA())
        """
        
        let contexto = Contexto(
            historia: historiaCompleta,
            personalidad:  "Es el personaje principal que guía al usuario a lo largo de la experiencia. Su personalidad destaca por ser sumamente relajada, confiable y leal. Actúa como el soporte estratégico de la historia, manteniendo siempre el control y transmitiendo calma al usuario durante la búsqueda de las piezas. Su lenguaje es profesional pero accesible, adaptado al entorno universitario de IADA, lo que le permite conectar de manera efectiva con los estudiantes de Diseño Digital y mantenerlos motivados durante todo el recorrido interactivo.",
            acciones_disponibles: [],
            estados_disponibles: estado_actual!.posibles_estados,
            estado_actual: nombre_estado_actual!,
            descripcion: estado_actual!.descripcion
        )
        return contexto
    }
    
    func inicializar() {
    }
    
    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        estado_actual?.actualizar(tipo_interaccion, interaccion)
    }
    
    func finalizar() {}
    
    func reaccion(estimulo: String) {}
    
    func realizar_cambio_de_estado(a nombre_del_estado_nuevo: String) {
        guard var estado_nuevo = estados_disponibles[nombre_del_estado_nuevo] else {
            fatalError("Parece que el estado \(nombre_del_estado_nuevo) no esta disponible o registrado, por favor revisa.")
        }
        nombre_estado_actual = nombre_del_estado_nuevo
        
        estado_actual?.finalizar()
        
        estado_nuevo.contexto = self as MaquinaEstadosGenerica
        estado_nuevo.inicializar()
        
        estado_actual = estado_nuevo
    }
}
