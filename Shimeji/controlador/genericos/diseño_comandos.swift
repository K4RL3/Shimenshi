//
//  diseño_comandos.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

import SwiftUI

protocol PorcesarComandos{
    func realizar_comando(tipo: Comandos, carga_util: String) -> Bool
    
    func realizar_comando(_ comando: Comando) -> Bool
}

enum Comandos{
    case activar_animacion
    case activar_pantalla
}

public struct Comando: Identifiable{
    public let id = UUID()
    
    let tipo: Comandos
    let carga_util: String
}

