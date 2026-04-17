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
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("RealityKit.NotificationTrigger"))){ notification in
                    guard let notification = notification.userInfo?["RealityKit.NotificationTrigger.Identifier"] as? String else { return }
                    
                    controlador.escuchar_comportamiento(notification)
                }
            }
        }
        Slider(value: $legitud)
            .onChange(of: legitud){
                controlador.alejar_planetas(legitud: legitud)
            }
        
        VStack{
            Button{
                controlador.alejar_planetas(legitud: legitud)
            }
            label:{
                Text("Alejar planetas")
                    .foregroundStyle(Color.orange)
            }
            
            Button{
                controlador.realizar_comando(tipo: .activar_animacion, carga_util: "salta_condenado")
            }
            label:{
                Text("Da un saltito")
                    .foregroundStyle(Color.orange)
            }
        }
        HStack{
            ForEach(controlador.historial_comandos){comando in
                Text("Comando ejecutado \(comando.carga_util)")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}

