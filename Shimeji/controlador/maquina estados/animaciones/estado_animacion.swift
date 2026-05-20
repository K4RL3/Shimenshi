//
//  estados_animacion.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class MaquinaEstadosCapi: MaquinaEstadosGenerica{
    func realizar_cambio_de_estado(a nombre_del_estado_nuevo: String) { }
    
    var posibles_estados: [String] = []
    
    static var nombre: String = "MaquinaCapi"
    
    var descripcion: String = "Controlador de reacciones de Capi"
    
    var contexto: (any MaquinaEstadosGenerica)?
    
    var controlador_general: (any ProcesarComandos)?
    

    var estados_disponibles: [String: Estado] = [
        ReposoAnimacion.nombre: ReposoAnimacion(),
        SaltoAnimacion.nombre: SaltoAnimacion(),
        PlanetasDesaparecidos.nombre: PlanetasDesaparecidos()
    ]
    
    var estado_actual: Estado? = nil
    
    init(){
        estado_actual = estados_disponibles[ReposoAnimacion.nombre]
        estado_actual?.contexto = self
    }
    

    
    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        estado_actual?.actualizar(tipo_interaccion, interaccion)
    }
    

    
    func inicializar() { }
    
    func finalizar() { }
    
    func reaccion(estimulo: String) { }
    
    func generar_descripcion() -> String {
        return ""
    }
    
    func generar_contexto_textual() -> Contexto {
        let contexto = Contexto(
            historia: "Es el personaje principal que guía al usuario a lo largo de la experiencia. Su personalidad destaca por ser sumamente relajada, confiable y leal. Actúa como el soporte estratégico de la historia, manteniendo siempre el control y transmitiendo calma al usuario durante la búsqueda de las piezas. Su lenguaje es profesional pero accesible, adaptado al entorno universitario de IADA, lo que le permite conectar de manera efectiva con los estudiantes de Diseño Digital y mantenerlos motivados durante todo el recorrido interactivo.",
            personalidad: "",
            estados_disponibles: estado_actual!.posibles_estados,
            estado_actual:  ["Dar pista", "Festejar", "Lamentarse"],,
            descrpcion: "",
        )
        
        return contexto
    }
}
