//
//  estados_animacion.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class MaquinaEstadosAnimacion: MaquinaEstadosGenerico {
    var controlador_general: (any PorcesarComandos)?
    
    func realizarr_cambio_estado(nombre_del_estado_nuevo: String) {
        <#code#>
    }
    
    func enviar_peticion(_ comando: Comando) -> Bool {
        guard let respuesta = controlador_general?.realizar_comando(comando) else {
            return false
        }
        
        return respuesta
    }
    
    var estados_disponibles: [String: Estado] = [
        RepospAnimacion.nombre: RepospAnimacion(),
        SaltoAnimccion.nombre: SaltoAnimccion()
                                                 
    ]
    var estado_actual: Estado? = nil
    
    init(){
        estado_actual = estados_disponibles[RepospAnimacion.nombre]
    }

    
    func realizar_cambio_estado(nombre_del_estado_nuevo: String){
        guard let estado_nuevo = estados_disponibles[nombre_del_estado_nuevo] else {
            fatalError("parece que el estado \(nombre_del_estado_nuevo) no esta registrado revisa eso")
        }
        
        estado_actual?.finalizar()
        
        estado_nuevo.inicializar()
        
        estado_actual = estado_nuevo
        
    }
    func actualizar(_ evento: String){
        estado_actual?.actualizar(evento)
    }

}
