//
//  buscando_pistas.swift
//  Shimeji
//
//  Created by alumno on 5/20/26.
//

import Foundation

class BuscandoPista: Estado {
    var descripcion: String = "Capi tiene su mapa en la mano y está olfateando el rastro del Ajolote."
    static let nombre: String = "BuscandoPista"
    var posibles_estados: [String] = ["CelebrandoHallazgo", "ReposoCapi"]
    var contexto: (any MaquinaEstadosGenerica)? = nil

    func inicializar() {
        print("¡Iniciando búsqueda! Capi activa su animación de rastreo.")
        // Aquí podrías disparar la animación de Capi mirando el mapa
        contexto?.enviar_peticion(Comando(tipo: .activar_animacion, carga_util: "mirar_mapa"))
    }

    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        // Si la cámara detecta la imagen (notificación de ARKit)
        if tipo_interaccion == .notificacion {
            contexto?.realizar_cambio_de_estado(a: "CelebrandoHallazgo")
        }
    }

    func finalizar() { }
    func reaccion(estimulo: String) { }
    func prueba(estimulo: String) { }
}
