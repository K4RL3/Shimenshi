import SwiftUI
import RealityKit
import mundo_virtual

struct EscenaPistaARView: View {
    let indicePista: Int
    let alCompletar: () -> Void
    
    func obtenerNombreEscena() -> String {
            let escenas = [
                "esenas/celebracion_final", // La carpeta sin 'c', el archivo con 'c'
                "esenas/escena1", // Ejemplo de otra escena que vi en tu imagen
                "esenas/caminando_a_pieza",
                "esenas/caminando_saludo",
                "esenas/asamblado1 1"
            ]
            
            if indicePista >= 0 && indicePista < escenas.count {
                return escenas[indicePista]
            } else {
                return "esenas/celebracion_final" // El respaldo también debe estar bien escrito
            }
        }
    
    var body: some View {
        ZStack {
            // 1. EL FONDO (Adiós cámara real, hola fondo de tu juego)
            LinearGradient(gradient: Gradient(colors:[Color.cyan, Color.blue.opacity(0.8)]),
                           startPoint: .topLeading,
                           endPoint: .bottomLeading)
            .ignoresSafeArea()
            
            // 2. EL VISOR DEL MODELO 3D
            // LA CÁMARA Y EL MODELO AR
                        RealityView { content in
                            let ancla = AnchorEntity(world: [0, -0.5, -1.0])
                            let nombreArchivo = obtenerNombreEscena() // Averiguamos qué cargar
                            
                            // ✅ PONEMOS ESTO AFUERA DEL TASK (Soluciona el error inout)
                            content.add(ancla)
                            
                            Task {
                                do {
                                    print("⏳ Intentando cargar modelo: \(nombreArchivo)")
                                    let escena = try await Entity(named: nombreArchivo, in: MundoVirtual)
                                    
                                    // Solo le pegamos la escena al ancla (que ya está en el mundo)
                                    ancla.addChild(escena)
                                    
                                    // Si tiene animación, la arranca
                                    if let animacion = escena.availableAnimations.first {
                                        escena.playAnimation(animacion.repeat())
                                    }
                                } catch {
                                    print("❌ No se encontró el modelo \(nombreArchivo): \(error)")
                                }
                            }
                        }
                        .ignoresSafeArea()
            
            // 3. LA INTERFAZ (Textos y Botón)
            VStack {
                VStack(spacing: 5) {
                    Text("PISTA \(indicePista + 1) REVELADA")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color.yellow)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
                    
                    Text("¡Mira lo que encontramos!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                }
                .padding(.top, 50)
                
                Spacer()
                
                VStack {
                    Button(action: {
                        alCompletar()
                    }) {
                        Text("Continuar")
                            .font(.system(.title2))
                            .fontWeight(.black)
                            .foregroundColor(Color.cyan)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
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
