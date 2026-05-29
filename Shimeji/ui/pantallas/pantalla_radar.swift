import SwiftUI
import CoreLocation

struct PantallaRadarView: View {
    var controlador: ControladorAplicacion
    
    // El índice reactivo
    @State var indicePistaActual: Int
    
    @State private var animarRadar = false
    @State private var mostrarVisor3D = false
    
    // 🔥 NUEVO: Estado para controlar la presentación del Chat de IA
    @State private var mostrarChatIA = false
    
    var body: some View {
        // Variables dinámicas
        let pistaActual = pistas[indicePistaActual]
        let ubicacionGPS = controlador.rastreadorGPS.ubicacionActual
        let fuerzaSenal = pistaActual.calcular_porcentaje(ubicacion: ubicacionGPS) ?? 0.0
        let estaEnRadar = pistaActual.esta_en_rango(ubicacion: ubicacionGPS)
        let sePuedeRecoger = pistaActual.puede_ser_recogida(ubicacion: ubicacionGPS)
        
        // CONTENEDOR PRINCIPAL
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue.opacity(0.8)]),
                           startPoint: .topLeading, endPoint: .bottomLeading)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // CABECERA
                VStack(spacing: 8) {
                    Text("RASTREADOR ACTIVO")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color.yellow)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
                    
                    Text(String(format: "Intensidad de señal: %.0f%%", fuerzaSenal))
                        .font(.headline)
                        .foregroundColor(fuerzaSenal > 80 ? .white : (fuerzaSenal > 40 ? .yellow : .white))
                }
                .padding(.top, 40)
                
                Spacer()
                
                // ANIMACIÓN RADAR
                ZStack {
                    Circle().fill(Color.white.opacity(0.2)).frame(width: 80, height: 80)
                    Circle().stroke(fuerzaSenal >= 95 ? Color.purple.opacity(0.8) : (fuerzaSenal > 50 ? Color.yellow.opacity(0.8) : Color.yellow.opacity(0.6)), lineWidth: 3).frame(width: 80, height: 80).scaleEffect(animarRadar ? 3.5 : 1.0).opacity(animarRadar ? 0.0 : (fuerzaSenal > 0 ? 1.0 : 0.3))
                    Circle().stroke(Color.cyan.opacity(0.8), lineWidth: 3).frame(width: 80, height: 80).scaleEffect(animarRadar ? 2.5 : 1.0).opacity(animarRadar ? 0.0 : (fuerzaSenal > 0 ? 1.0 : 0.3)).animation(Animation.easeOut(duration: (fuerzaSenal > 80 ? 1.0 : 2.0)).repeatForever(autoreverses: false).delay(0.5), value: animarRadar)
                    
                    Image(systemName: sePuedeRecoger ? "arkit" : "location.viewfinder")
                        .font(.system(size: 40))
                        .foregroundColor(sePuedeRecoger ? .purple : .white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .frame(height: 250)
                .onAppear {
                    withAnimation(Animation.easeOut(duration: 2.0).repeatForever(autoreverses: false)) {
                        animarRadar = true
                    }
                }
                
                Spacer()
                
                // TARJETA DE ACCIONES
                VStack(spacing: 15) {
                    if sePuedeRecoger {
                        Text("¡PISTA ENCONTRADA! 🐾")
                            .font(.subheadline).fontWeight(.black).foregroundColor(.green)
                        
                        Text("Has llegado al origen de la señal.")
                            .font(.body).foregroundColor(.black)
                            .multilineTextAlignment(.center).padding(.horizontal)
                        
                        Button(action: {
                            mostrarVisor3D = true // ABRE LA VISTA 3D
                        }) {
                            Text("Recolectar Pista")
                                .fontWeight(.black).foregroundColor(.white)
                                .padding().frame(maxWidth: .infinity)
                                .background(Color.green).cornerRadius(15)
                        }
                    } else if estaEnRadar {
                        Text("SEÑAL DETECTADA")
                            .font(.subheadline).fontWeight(.black).foregroundColor(.cyan)
                        Text("Sigue buscando alrededor, la señal se hace más fuerte...")
                            .foregroundColor(.black).multilineTextAlignment(.center)
                        
                        // 🔥 NUEVO: Botón para consultar a la IA si están cerca pero ocupan ayuda
                        Button(action: {
                            mostrarChatIA = true
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Pedir pista al Agente IA")
                            }
                            .fontWeight(.black).foregroundColor(.white)
                            .padding().frame(maxWidth: .infinity)
                            .background(Color.cyan).cornerRadius(15)
                        }
                    } else {
                        Text("BUSCANDO RASTRO...")
                            .font(.subheadline).fontWeight(.black).foregroundColor(.gray)
                        Text("Camina por el campus para encontrar la siguiente pista.")
                            .foregroundColor(.gray).multilineTextAlignment(.center)
                        
                        // 🔥 NUEVO: Botón para consultar a la IA si están completamente perdidos
                        Button(action: {
                            mostrarChatIA = true
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Analizar entorno con IA")
                            }
                            .fontWeight(.black).foregroundColor(.white)
                            .padding().frame(maxWidth: .infinity)
                            .background(Color.blue).cornerRadius(15)
                        }
                    }
                }
                .padding(.vertical, 25).padding(.horizontal, 15)
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.white).shadow(radius: 10))
                .padding(.horizontal, 25).padding(.bottom, 40)
            }
        }
        .fullScreenCover(isPresented: $mostrarVisor3D) {
            EscenaPistaARView(indicePista: indicePistaActual) {
                // AVANZAMOS A LA SIGUIENTE PISTA AL CERRAR
                if indicePistaActual < pistas.count - 1 {
                    indicePistaActual += 1
                } else {
                    print("¡Juego completado!")
                }
            }
        }
        // 🔥 NUEVO: MODIFICADOR DE HOJA FLOTANTE PARA EL CHAT DE IA 🔥
        .sheet(isPresented: $mostrarChatIA) {
            ChatView()
                // Abre el chat a la mitad para mantener el contexto visual del radar abajo
                .presentationDetents([.medium, .large])
                // Añade la pequeña barra visual superior que indica que se puede deslizar hacia abajo
                .presentationDragIndicator(.visible)
        }
    }
}
