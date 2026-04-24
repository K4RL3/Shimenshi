//
//  estado_reposo.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class RepospAnimacion: Estado{
    var contexto: (any MaquinaEstadosGenerico)? = nil
    
    static let nombre: String = "Reposo"

    func inicializar() {}
    
    func actualizar(_ evento: String) {
        print("\(#function) recibiendo datos del evento \(evento)")
        
        switch evento{
        case "salta_condenado":
            contexto?.enviar_peticion(Comando(tipo: .activar_animacion, carga_util: "salta_condenado"))
            contexto?.realizarr_cambio_estado(a: SaltoAnimccion.nombre)

                
            default:
                print("Comanod no especifciado")
        }
    }
    
    func finalizar() {}
    
    func reacion(estimulo: String) {}
    
    
}
