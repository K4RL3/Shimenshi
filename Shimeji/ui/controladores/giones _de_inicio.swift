//
//  giones _de_inicio.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 29/05/26.
//

struct NodoHistoria {
    let texto: String
    let nombreAnimacion: String // El nombre del archivo en Reality Composer
}

// Ejemplo de tu historia (puedes expandir esta lista)
let guionJuego = [
    NodoHistoria(texto: "¡No manches! El guardia pasó sin ver a mi amigo y terminó hecho puras piezas por todo el IADA.", nombreAnimacion: "esenas/capi_hablausda"),
    NodoHistoria(texto: "Solo no voy a poder juntar todo antes de que alguien lo barra o se lo lleve el viento, ¡está muy disperso!", nombreAnimacion: "ajo_modelos/animaciones/muerte"),
    NodoHistoria(texto: "¡Ayúdame a rastrear cada pieza con tu radar, carnal! Sin ti, mi compa se va a quedar desarmado para siempre", nombreAnimacion: "piezas-animaciones/pata")
]
