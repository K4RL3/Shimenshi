//
//  ShimejiApp.swift
//  Shimeji
//
//  Created by alumno on 4/13/26.
//

import SwiftUI

@main
struct ShimejiApp: App {
    @State var controlador_general = ControladorAplicacion()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(controlador_general)
        }
    }
}
