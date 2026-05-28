//
//  estados_animacion.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 28/05/26.
//

//class MaquinaEstadosAnimacion: MaquinaEstadosGenerica{
//    
//    var controlador_general: (any ProcesarComandos)?
//    var contexto: (any MaquinaEstadosGenerica)?
//    var descripcion: String = "Esta es la maquina de estados de animación."
//    static var nombre: String = "Máquina estados animación."
//    var estados_disponibles: [String : any Estado] = [:]
//    var estado_actual: Estado? = nil
//    var posibles_estados: [String] = []
//    
//    init(){
//        estado_actual = estados_disponibles[PersonajeFeliz.nombre]
//        estado_actual?.contexto = self
//    }
//    func realizar_cambio_de_estado(a nombre_del_estado_nuevo: String) {
//    
//    }
//    
//    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
//        estado_actual?.actualizar(tipo_interaccion, interaccion)
//    }
//    
//    func inicializar() {
//    }
//    
//    func finalizar() {
//    }
//    
//    func reaccion(estimulo: String) {
//    }
//    func generar_descripcion() -> String {
//        return ""
//    }
//    
//    func generar_contexto_textual() -> Contexto {
//        let contexto = Contexto(
//            historia: "Historia del personaje",
//            personalidad: "La personalidad del agente.",
//            estados_disponibles: estado_actual!.posibles_estados,
//
//        )
//    }
//}
