import Foundation

/// Bundle for the mundo virtual project
public let MundoVirtual = Bundle.module

public let escenario_animacion = "capi_animaciones/cappi_animado"

public let capibara_prueba = [
    "capi_animaciones/cappi_animado",
    "capi_animaciones/cappi_animado",
    "capi_animaciones/cappi_animado"
]

enum Notificaciones {
    case ildie
}

let Notificacion: [Notificaciones: String] = [
    Notificaciones.ildie: "ildie"
]
