//
//  gestor_maquina_estado.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

protocol MaquinaEstadosGenerico {
    var controlador_general: PorcesarComandos? { get set }
    
    func realizarr_cambio_estado(nombre_del_estado_nuevo: String) -> Void
    
    func actualizar(_ evento: String) -> Void
    
    func enviar_peticion (_ comando : Comando) -> Bool
}
