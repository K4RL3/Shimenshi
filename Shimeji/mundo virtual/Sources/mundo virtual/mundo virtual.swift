import Foundation

/// Bundle for the mundo virtual project
public let MundoVirtual = Bundle.module

public let escenario_planeta = "Planetario/escena"

public let planetas = [
    "Planetario/escena",
    "Planetario/escena",
    "Planetario/escena",
    "Planetario/escena",
    "Planetario/escena",
    "Planetario/escena",
    "Planetario/escena",
    "Planetario/escena"
]

enum Notificaciones {
    case salta_condenado
}

let Notificacion: [Notificaciones: String] = [
    Notificaciones.salta_condenado: "salta_condenado"
]
