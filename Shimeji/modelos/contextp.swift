//
//  contextp.swift
//  Shimeji
//
//  Created by alumno on 5/6/26.
//

import Foundation

struct Contexto: Codable {
    var historia: String
    var personalidad: String
    var acciones_disponibles: [String]
    var estados_disponibles: [String]
    var estado_emocional: String
}
