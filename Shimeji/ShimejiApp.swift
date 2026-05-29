//
//  ShimejiApp.swift
//  Shimeji
//
//  Created by alumno on 4/13/26.
//

import SwiftUI
import FirebaseCore
import CoreLocation

@main
struct ShimejiApp: App {
    // 1. Aquí creas el "cerebro" oficial y lo mantienes vivo en memoria
    @State var controlador_general = ControladorAplicacion()
    
    init (){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
            WindowGroup {
                PantallaTest()
                    .environment(controlador_general)
            }
        }
}
