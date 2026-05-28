//
//  ajo_gestor_maquina_estados.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 28/05/26.
//

class AjoGestorEstados: MaquinaEstadosGenerica{
    
    var contexto: (any MaquinaEstadosGenerica)?
    var descripcion: String = "No tomar en cuenta descripción."
    var posibles_estados: [String] = []
    static var nombre: String = "Gestor de Estados Ajo."
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
            historia: "Es un juguete armable que llegó muy emocionado a Ciudad Juárez en plan de turista para conocer la frontera y tomarse fotos en la famosa X. Lamentablemente, mientras cruzaba una avenida transitada de la ciudad, fue atropellado, lo que provocó que sus piezas magnéticas salieran volando y se dispersaran por diferentes puntos turísticos y calles de Juárez. Ahora está varado en la ciudad y necesita la ayuda de la sabiduría del Capibara y el apoyo del usuario para recolectar todas sus partes, armarse de nuevo y poder continuar con sus vacaciones norteñas.",
            personalidad:  "Es un juguete sumamente curioso, aventurero y con un espíritu viajero inquebrantable. A pesar del accidente, no pierde su actitud de turista emocionado; es distraído pero muy carismático, y ve el haber sido atropellado como una anecdota extrema de sus vacaciones en la frontera. Le encanta aprender modismos locales, quiere probar todos los burritos de la ciudad y siempre mantiene una actitud positiva y agradecida con el usuario cada vez que encuentra una de sus piezas para poder seguir turisteando.",
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
