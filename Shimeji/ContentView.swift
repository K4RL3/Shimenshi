
import SwiftUI
import RealityKit
import mundo_virtual

struct ContentView: View{
    @State var lejitud: Float = 0
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        ZStack{
            Rectangle()
            VStack{
                switch controlador.estado{
                    case .inciando:
                        Text("Cargando aplciacion, por favor espera")
                            .foregroundStyle(Color.red)
                        
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
        }
        
        Slider(value: $lejitud, in: 0...5)
            .onChange(of: lejitud) {
                controlador.alejar_planetas(lejitud: lejitud)
            }
        
        HStack{
            Button{
                controlador.alejar_planetas(lejitud: lejitud)
            }
            label: {
                Text("Alejar planetas")
                    .foregroundStyle(Color.red)
            }
            
            Button{
                controlador.actualizar_estados("da_un_salto")
            }
            label: {
                Text("Da un saltito")
                    .foregroundStyle(Color.red)
            }
        }
        
        HStack{
            ForEach(controlador.historial_comandos){ comando in
                Text("Comando ejectudado \(comando.carga_util) ")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
