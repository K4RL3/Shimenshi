import Foundation

/// Bundle for the mundo virtual project
public let MundoVirtual = Bundle.module

public let escena_caminar_saludo = "caminar_saludo"

enum Notificaciones {
    case caminar_saludo
    case salta_condenado
}

let Notificacion: [Notificaciones: String] = [
    Notificaciones.salta_condenado: "salta_condenado",
    Notificaciones.caminar_saludo: "caminar_saludo"
]
