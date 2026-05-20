//
//  reposo_capi.swift
//  Shimeji
//
//  Created by alumno on 5/20/26.
//

import Foundation

class ReposoCapi: Estado {
    var descripcion: String = "Capi está tranquilo, esperando a que busquemos la siguiente pista del Ajolote."
    static let nombre: String = "ReposoCapi"
    var posibles_estados: [String] = ["BuscandoPista"]
    var contexto: (any MaquinaEstadosGenerica)? = nil

    func inicializar() {
        print("Capi entra en estado de reposo.")
    }

    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        switch tipo_interaccion {
        case .boton:
            if interaccion == .realizar_accion {
                // Si picamos el botón de "Buscar", cambiamos de estado
                contexto?.realizar_cambio_de_estado(a: "BuscandoPista")
            }
        default:
            break
        }
    }

    func finalizar() { }
    func reaccion(estimulo: String) { }
    func prueba(estimulo: String) { }
}
