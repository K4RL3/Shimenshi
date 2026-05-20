//
//  celebrando_capi.swift
//  Shimeji
//
//  Created by alumno on 5/20/26.
//

import Foundation

class CelebrandoHallazgo: Estado {
    var descripcion: String = "¡Encontramos una pieza! Capi está saltando de felicidad."
    static let nombre: String = "CelebrandoHallazgo"
    var posibles_estados: [String] = ["BuscandoPista", "ReposoCapi"]
    var contexto: (any MaquinaEstadosGenerica)? = nil

    func inicializar() {
        print("¡Pieza de Ajolote encontrada!")
        // Disparamos la animación de salto
        contexto?.enviar_peticion(Comando(tipo: .activar_animacion, carga_util: "yipie"))
    }

    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        // Después de celebrar, regresamos a buscar la siguiente
        if interaccion == .realizar_accion {
            contexto?.realizar_cambio_de_estado(a: "BuscandoPista")
        }
    }

    func finalizar() { }
    func reaccion(estimulo: String) { }
    func prueba(estimulo: String) { }
}
