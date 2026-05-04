//
//  ShimejiApp.swift
//  Shimeji
//
//  Created by alumno on 4/13/26.
//

import SwiftUI
import FirebaseCore

@main
struct ShimejiApp: App {
    @State var controlador_general = ControladorAplicacion()
    
    init (){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SeguimientoImagenes()
                .environment(controlador_general)
        }
    }
}
