//
//  controlador_notificacion.swift
//  Shimeji
//
//  Created by alumno on 4/17/26.
//

import SwiftUI
import RealityKit

extension ControladorAplicacion {
    func activar_comportamiento(_ nombre: String){
        estado_animacion.actualizar(nombre)
    }
    
    
    func escuchar_comportamiento(_ nombre: String){
        ///print("nombre de finalizacon comportamiento \(nombre)")
        estados_animacion.actualizar(nombre)
    }
}
