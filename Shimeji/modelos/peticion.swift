//
//  peticion.swift
//  Shimeji
//
//  Created by alumno on 5/6/26.
//

import Foundation

enum EstadoPeticion: String, Codable{
    case creacion
    case procesamiento
    case resultado
}

struct Peticion: Codable, Identifiable{
    var id: String
    var estado: EstadoPeticion
    var contexto: Contexto
    var mensaje: String
    var animacion: String?
    var comando_a_ejecutar: Comando?
    var respuesta: String?
}
