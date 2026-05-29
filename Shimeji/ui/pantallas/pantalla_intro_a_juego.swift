import SwiftUI
import RealityKit
import mundo_virtual

struct PantallaNarrativaView: View {
    @State private var indicePagina = 0
    @Environment(ControladorAplicacion.self) var controlador
    
    // Aquí solo declaramos la variable que recibirá el guion
    let alFinalizarHistoria: () -> Void
    
    @State private var mostrarRadar = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                // 1. EL MODELO 3D
                RealityView { content in
                    let ancla = AnchorEntity(world: [0, -0.5, -1.5])
                    content.add(ancla)
                } update: { content in
                    let nombre = guionJuego[indicePagina].nombreAnimacion
                    if let ancla = content.entities.first {
                        ancla.children.removeAll()
                        Task {
                            if let entidad = try? await Entity(named: nombre, in: MundoVirtual) {
                                entidad.position = [0, 0.1, 2.8]
                                ancla.addChild(entidad)
                            }
                        }
                    }
                }
                
                // 2. INTERFAZ
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Capi:")
                            .font(.caption).bold().foregroundColor(.yellow)
                        
                        Text(guionJuego[indicePagina].texto)
                            .font(.title3).foregroundColor(.white)
                        
                        Button(action: {
                            if indicePagina < guionJuego.count - 1 {
                                indicePagina += 1
                            } else {
                                mostrarRadar = true
                            }
                        }) {
                            Text(indicePagina < guionJuego.count - 1 ? "Siguiente" : "¡Buscar Pistas!")
                                .fontWeight(.black).padding().frame(maxWidth: .infinity)
                                .background(Color.white).cornerRadius(15).foregroundColor(.cyan)
                        }
                    }
                    .padding(25)
                    .background(Color.black.opacity(0.6).cornerRadius(25))
                    .padding(20)
                }
            }
            .navigationDestination(isPresented: $mostrarRadar) {
                            PantallaRadarView(
                                controlador: controlador,
                                indicePistaActual: 0
            )
            .navigationBarBackButtonHidden(true)
            }
        }
    }
}
#Preview {

    // Pasamos el guion de prueba al inicializador
    PantallaNarrativaView( alFinalizarHistoria: {})
        .environment(ControladorAplicacion()) // Mantenemos el entorno necesario
}
