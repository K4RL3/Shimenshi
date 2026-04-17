//
//  extencion_Scene.swift
//  Shimeji
//
//  Created by alumno on 4/17/26.
//
import RealityKit
import SwiftUI

extension RealityKit.Scene {
    func envirar_notificaciones(_ nombre: String){
        let nombre_notificacion = Notification.Name("RealityKit.NotificationTriggger")
        let informacion_general: [String: Any] = [
        "RealityKit.NotificationTrigger.Scene": self,
        "RealityKit.NotificationTrigger.Identifier": nombre
        ]
        
        NotificationCenter.default.post(name: nombre_notificacion, object: nil, userInfo: informacion_general)
    }
}
