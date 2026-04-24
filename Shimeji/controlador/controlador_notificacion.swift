//
//  controlador_notificacion.swift
//  Shimeji
//
//  Created by alumno on 4/17/26.
//

import SwiftUI
import RealityKit

extension ControladorAplicacion{
    func activar_comportamiento(_ nombre: String){
        raiz_escena.scene?.enviar_notificacion(nombre)
    }
    
    func escuchar_comportamiento(_ nombre: String){
        /// print("nombre de finalizacion comprotamiento: \(nombre)")
        actualizar_estados(nombre)
    }
}


