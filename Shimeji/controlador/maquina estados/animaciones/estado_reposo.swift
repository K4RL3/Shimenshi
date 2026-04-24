//
//  estado_reposo.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class ReposoAnimacion: Estado{
    var contexto: (any MaquinaEstadosGenerica)? = nil
    
    static let nombre: String = "Reposo"

    
    func inicializar() { }
    
    func actualizar(_ evento: String) {
        print("\(#function) recibiendo informacion del tipo evento con datos \(evento)")
        
        switch evento{
            case "da_un_salto":
                contexto?.enviar_peticion(Comando(tipo: .activar_animacion, carga_util: "da_un_salto"))
                contexto?.realizar_cambio_de_estado(a: SaltoAnimacion.nombre)
                
            default:
                print("Comanod no especifciado")

        }
    }
    
    func finalizar() { }
    
    func reaccion(estimulo: String) { }

}
