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
        PersonajeFeliz.nombre: PersonajeFeliz()
    ]
    var estado_actual: Estado? = nil
    var nombre_estado_actual: String?
    
    init(){
        estado_actual = estados_disponibles[PersonajeNeutro.nombre]
        estado_actual?.contexto = self
    }
    
    
    func generar_contexto_textual() -> Contexto {
        print("Traza")
        
        let contexto = Contexto(
            historia: "Es un tierno peluche viajero que llegó a Ciudad Juárez listo para la aventura, equipado con su pequeña mochilita y un mapa de la  Destaca por ser el planificador del viaje: un explorador organizado, calmado y de gran corazón que se encargó de trazar la ruta perfecta para conocer los lugares más icónicos de la ciudad y de IADA. Tras el inesperado accidente donde su compañero Ajolote quedó desarmado, el Capibara no se paniquea; toma el control de la situación, se ajusta la mochila y usa su mapa como la guía estratégica definitiva para coordinar al usuario en la búsqueda de las piezas, decidido a rescatar a su amigo y demostrar que nada puede arruinar su gran viaje norteño.",
            personalidad:  "Es el personaje principal que guía al usuario a lo largo de la experiencia. Su personalidad destaca por ser sumamente relajada, confiable y leal. Actúa como el soporte estratégico de la historia, manteniendo siempre el control y transmitiendo calma al usuario durante la búsqueda de las piezas. Su lenguaje es profesional pero accesible, adaptado al entorno universitario de IADA, lo que le permite conectar de manera efectiva con los estudiantes de Diseño Digital y mantenerlos motivados durante todo el recorrido interactivo.",
            acciones_disponibles: [],
            estados_disponibles: estado_actual!.posibles_estados,
            estado_emocional: "",
            estado_actual: nombre_estado_actual!,
            descripcion: estado_actual!.descripcion
        )
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
    }
}
