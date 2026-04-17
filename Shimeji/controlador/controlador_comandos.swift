//
//  controlador_comandos.swift
//  Shimeji
//
//  Created by alumno on 4/17/26.
//
import SwiftUI

enum Comandos{
    case activar_animacion
}

public struct Comando: Identifiable{
    public let id = UUID()
    
    let tipo: Comandos
    let carga_util: String
}

extension ControladorAplicacion{
    func realizar_comando(tipo: Comandos, carga_util: String) -> Bool {
        switch tipo{
        case .activar_animacion:
            activar_comportamiento(carga_util)
            historial_comandos.append(
                Comando(tipo: tipo, carga_util: carga_util)
            )
            return true
        }
        
        return false
    }
}
