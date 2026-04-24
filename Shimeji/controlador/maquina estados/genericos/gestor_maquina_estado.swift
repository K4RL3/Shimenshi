//
//  gestor_maquina_estado.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//


protocol MaquinaEstadosGenerica{
    var controlador_general: ProcesarComandos? { get set }
    
    func realizar_cambio_de_estado(a nombre_del_estado_nuevo: String) -> Void
    
    func actualizar(_ evento: String) -> Void
    
    func enviar_peticion(_ comando: Comando) -> Bool
}
