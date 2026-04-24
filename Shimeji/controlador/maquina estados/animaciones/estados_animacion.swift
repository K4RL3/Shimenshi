//
//  estados_animacion.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class MaquinaEstadosAnimacion: MaquinaEstadosGenerico {
    var controlador_general: (any PorcesarComandos)?
    
    var estados_disponibles: [String: Estado] = [
        RepospAnimacion.nombre: RepospAnimacion(),
        SaltoAnimccion.nombre: SaltoAnimccion(),
        PlanetasDesaparecidos.nombre: PlanetasDesaparecidos()
    ]
    
    var estado_actual: Estado? = nil
    
    init(){
        estado_actual = estados_disponibles[RepospAnimacion.nombre]
        estado_actual?.contexto = self
    }
    
    func realizarr_cambio_estado(nombre_del_estado_nuevo: String) {
        guard var estado_nuevo = estados_disponibles[nombre_del_estado_nuevo] else {
            fatalError("Parece que el estado \(nombre_del_estado_nuevo) no esta disponibleno esta disponible o registrado, por favor revisa.")
        }
        estado_actual?.finalizar()
        
        estado_nuevo.contexto = self as MaquinaEstadosAnimacion
        estado_nuevo.inicializar()
        
        estado_actual = estado_nuevo
        
    }
    
    func actualizar(_ evento: String){
        estado_actual?.actualizar(evento)
    }
    
    func enviar_peticion(_ comando: Comando) -> Bool {
        guard let respuesta = controlador_general?.realizar_comando(comando) else {
            return false
        }
        
        return respuesta
    }
    
}
