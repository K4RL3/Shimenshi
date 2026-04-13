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
    var body: some View {
        ZStack{
            Rectangle()
                .background(Color.yellow)
            
            RealityView{ raiz_de_escena in
                if let modelo_cubo = try? await Entity(named: "escena", in: mundo_virtualBundle){
                    modelo_cubo.position.z = Float(legitud)
                    raiz_de_escena.add(modelo_cubo)
                }
            }
        }
        Slider(value: $legitud)
    }
}

#Preview {
    ContentView()
}
