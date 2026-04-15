//
//  ContentView.swift
//  Shimeji
//
//  Created by alumno on 4/13/26.
//

import SwiftUI
import RealityKit
import mundo_virtual

struct ContentView: View {
    @State var legitud: Float = 0
    @Environment(ControladorAplicacion.self) var controlador
    var body: some View {
        ZStack{
            Rectangle()
                .background(Color.yellow)
            
            RealityView{ raiz_de_escena in
                    raiz_de_escena.add(controlador.raiz_escena)
            }
        }
        Slider(value: $legitud)
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}

