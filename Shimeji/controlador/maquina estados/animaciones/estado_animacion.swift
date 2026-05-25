//
//  estados_animacion.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class MaquinaEstadosCapi: MaquinaEstadosGenerica {

    func realizar_cambio_de_estado(a nombre_del_estado_nuevo: String) { }
    
    var posibles_estados: [String] = []
    static var nombre: String = "MaquinaCapi"
    var descripcion: String = "Controlador de reacciones de Capi"
    var contexto: (any MaquinaEstadosGenerica)?
    var controlador_general: (any ProcesarComandos)?

    var estados_disponibles: [String: Estado] = [
        ReposoCapi.nombre: ReposoCapi(),
        BuscandoPista.nombre: BuscandoPista(),
        CelebrandoHallazgo.nombre: CelebrandoHallazgo()
    ]
    
    var estado_actual: Estado? = nil
    
    init(){
        estado_actual = estados_disponibles[ReposoCapi.nombre]
        estado_actual?.contexto = self
    }
    
    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        estado_actual?.actualizar(tipo_interaccion, interaccion)
    }
    
    func inicializar() { }
    func finalizar() { }
    func reaccion(estimulo: String) { }
    func generar_descripcion() -> String { return "" }
    
    func generar_contexto_textual() -> Contexto {
        return Contexto(
            historia: "Capi está en el campus de la UACJ buscando las piezas de su amigo Ajolote.",
            personalidad: "Amable, tierno y motivador.",
//            acciones_disponibles: ["Dar pista", "Festejar", "Lamentarse"],
            estados_disponibles: Array(estados_disponibles.keys),
            estado_actual: "",
            descripcion: ""
        )
    }
}
