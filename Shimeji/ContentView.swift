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
            
            switch controlador.estado{
            case .iniciando:
                Text ("Cargando aplicacion, porfavor espera")
                    .foregroundStyle(Color.yellow)
            case .todo_cargado:
                RealityView{ raiz_de_escena in
                    raiz_de_escena.add(controlador.raiz_escena)
                }
            }
        }
        Slider(value: $legitud)
            .onChange(of: legitud){
                controlador.alejar_planetas(legitud: legitud)
            }
        Button{
            controlador.alejar_planetas(legitud: legitud)
        }
        label:{
            Text("Alejar planetas")
                .foregroundStyle(Color.orange)
        }
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}

