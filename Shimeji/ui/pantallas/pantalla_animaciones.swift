import SwiftUI
import RealityKit
import mundo_virtual

struct EscenaPistaARView: View {
    let indicePista: Int
    let alCompletar: () -> Void
    @Environment(\.dismiss) var dismiss
    
    // Lista de escenas para identificar cuántas hay
    let escenas = [
        "ajo_modelos/piezas-modelos/Ajolote_brazo",
        "ajo_modelos/piezas-modelos/Ajolote_cola",
        "ajo_modelos/piezas-modelos/Ajolote_cososCabeza",
        "ajo_modelos/piezas-modelos/Ajolote_pata",
        "ajo_modelos/piezas-modelos/Ajolote_pata",
    ]
    
    // 🔥 Determinamos si es la última pieza (ensamblado final)
    var esElFinal: Bool {
        return indicePista >= escenas.count
    }
    
    func obtenerNombreEscena() -> String {
        if indicePista >= 0 && indicePista < escenas.count {
            return escenas[indicePista]
        } else {
            return "esenas/celebracion_final"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[Color.cyan, Color.blue.opacity(0.8)]),
                           startPoint: .topLeading, endPoint: .bottomLeading)
            .ignoresSafeArea()
            
            RealityView { content in
                let ancla = AnchorEntity(world: [0, -0.5, -1.0])
                let nombreArchivo = obtenerNombreEscena()
                content.add(ancla)
                
                Task {
                    if let escena = try? await Entity(named: nombreArchivo, in: MundoVirtual) {
                        ancla.addChild(escena)
                        if let animacion = escena.availableAnimations.first {
                            escena.playAnimation(animacion.repeat())
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 5) {
                    // 🔥 Texto que cambia al final
                    Text(esElFinal ? "¡AJOLOTE ENSAMBLADO!" : "PISTA \(indicePista + 1) REVELADA")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(esElFinal ? .yellow : .yellow)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                    
                    Text(esElFinal ? "Fin del juego, felicidades." : "¡Mira lo que encontramos!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                }
                .padding(.top, 50)
                
                Spacer()
                
                VStack {
                    Button(action: {
                        alCompletar()
                        dismiss()
                    }) {
                        // 🔥 Botón que cambia su texto al final
                        Text(esElFinal ? "Finalizar" : "Continuar")
                            .font(.system(.title2))
                            .fontWeight(.black)
                            .foregroundColor(esElFinal ? .white : .cyan)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(esElFinal ? Color.purple : Color.white) // Un color especial para el final
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                            )
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    EscenaPistaARView(indicePista: 0) {
        print("Continuando juego...")
    }
}
