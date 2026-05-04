//
//  mensaje.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//
import Foundation

struct Mensaje: Identifiable, Codable{
    var id: String
    var texto: String
    var remitente: String
    var timestamp: Date
}
