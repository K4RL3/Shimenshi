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
            
            switch controlador.estado{
            case .iniciando:
                Text ("Cargando aplicacion, porfavor espera")
                    .foregroundStyle(Color.yellow)
                
            case .todo_cargado:
                RealityView{ raiz_de_escena in
                    raiz_de_escena.add(controlador.raiz_escena)
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("RealityKit.NotificationTrigger"))){ notificacion in
                    guard let notificacion = notificacion.userInfo?["RealityKit.NotificationTrigger.Identifier"] as? String else { return }
                    

                    controlador.escuchar_comportamiento(notificacion)
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
                controlador.realizar_comando("salta_condenado")
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

