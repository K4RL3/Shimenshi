//
//  pantalla_radar.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 28/05/26.
//
import SwiftUI
import CoreLocation


struct PantallaRadarView: View {
    // Tu controlador general que inyectarás desde tu app
    var controlador: ControladorAplicacion
    
    // Aquí recibes la pista que el jugador debe buscar actualmente.
    // (Asegúrate de pasarle la pista activa desde tu Maquina de Estados)
    var pistaActual: Pista
    
    // Control de la animación
    @State private var animarRadar = false
    @State var indicePistaActual: Int = 0
    @State private var mostrarAnimacion = false
    
    var body: some View {
        // 1. EVALUACIÓN DE LA PISTA USANDO TUS FUNCIONES
        let ubicacionGPS = controlador.rastreadorGPS.ubicacionActual
        let fuerzaSenal = pistaActual.calcular_porcentaje(ubicacion: ubicacionGPS) ?? 0.0
        let sePuedeRecoger = pistaActual.puede_ser_recogida(ubicacion: ubicacionGPS)
        let estaEnRadar = pistaActual.esta_en_rango(ubicacion: ubicacionGPS)
        
        ZStack {
            // Fondo degradado continuo
            LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue.opacity(0.8)]),
                           startPoint: .topLeading,
                           endPoint: .bottomLeading)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // 2. CABECERA: Título y Fuerza de Señal
                VStack(spacing: 8) {
                    Text("RASTREADOR ACTIVO")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color.yellow)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
                    
                    Text(String(format: "Intensidad de señal: %.0f%%", fuerzaSenal))
                        .font(.headline)
                        // Cambia de color dependiendo de qué tan cerca estás (0 a 100%)
                        .foregroundColor(fuerzaSenal > 80 ? .white : (fuerzaSenal > 40 ? .yellow : .white))
                }
                .padding(.top, 40)
                
                Spacer()
                
                // 3. ANIMACIÓN DEL RADAR
                ZStack {
                    // Círculo central estático
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    // Anillo 1 expansivo
                    Circle()
                        .stroke(fuerzaSenal > 50 ? Color.yellow.opacity(0.8) : Color.yellow.opacity(0.6), lineWidth: 3)
                        .frame(width: 80, height: 80)
                        .scaleEffect(animarRadar ? 3.5 : 1.0)
                        .opacity(animarRadar ? 0.0 : (fuerzaSenal > 0 ? 1.0 : 0.3))
                    
                    // Anillo 2 expansivo (con retraso)
                    Circle()
                        .stroke(Color.cyan.opacity(0.8), lineWidth: 3)
                        .frame(width: 80, height: 80)
                        .scaleEffect(animarRadar ? 2.5 : 1.0)
                        .opacity(animarRadar ? 0.0 : (fuerzaSenal > 0 ? 1.0 : 0.3))
                        .animation(Animation.easeOut(duration: (fuerzaSenal > 80 ? 1.0 : 2.0)).repeatForever(autoreverses: false).delay(0.5), value: animarRadar)
                    
                    // Icono dinámico en el centro
                    Image(systemName: sePuedeRecoger ? "exclamationmark.bubble.fill" : "location.viewfinder")
                        .font(.system(size: 40))
                        .foregroundColor(sePuedeRecoger ? .green : .white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .frame(height: 250)
                .onAppear {
                    // Inicia la animación al cargar la vista
                    withAnimation(Animation.easeOut(duration: 2.0).repeatForever(autoreverses: false)) {
                        animarRadar = true
                    }
                }
                
                Spacer()
                
                // 4. TARJETA DE ACCIONES (Controlada por tus booleanos)
                VStack(spacing: 15) {
                    if sePuedeRecoger {
                        // ESTÁ A MENOS DE LA DISTANCIA MÍNIMA (Ej. 5 metros)
                        Text("¡PISTA ENCONTRADA! 🐾")
                            .font(.subheadline)
                            .fontWeight(.black)
                            .foregroundColor(.green)
                        
                        Text("Has llegado al origen de la señal. Abre la cámara para escanear.")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: {
                            mostrarAnimacion = true
                            // AQUÍ MANDAS EL COMANDO A TU CONTROLADOR
                            // controlador.actualizar_estados(...)
                            print("Botón presionado: Generar interacción")
                        }) {
                            Text("Recoger Pista")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(15)
                        }// ... justo después de cerrar el último cierre } del ZStack principal ...
                        .fullScreenCover(isPresented: $mostrarAnimacion) {
                            // Al llamar a la pantalla AR, le pasamos el índice de la pista actual
                            EscenaPistaARView(indicePista: indicePistaActual) {
                                // Cuando la animación termine (presionen "Continuar"), cerramos la pantalla AR
                                mostrarAnimacion = false
                                
                                // Incrementamos el índice para que la próxima vez cargue la siguiente escena
                                indicePistaActual += 1
                                
                                // Opcional: Aquí podrías llamar a tu controlador para actualizar la pista en el radar
                                // controlador.siguientePista()
                            }
                        }
                        
                    } else if estaEnRadar {
                        // ESTÁ ENTRE LA DISTANCIA MÍNIMA Y MÁXIMA (Ej. entre 5 y 100 metros)
                        Text("SEÑAL DETECTADA")
                            .font(.subheadline)
                            .fontWeight(.black)
                            .foregroundColor(.cyan)
                        
                        Text("Sigue buscando alrededor, la señal se hace más fuerte. ¡Vas por buen camino!")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                    } else {
                        // ESTÁ A MÁS DE LA DISTANCIA MÁXIMA (Ej. > 100 metros)
                        Text("BUSCANDO RASTRO...")
                            .font(.subheadline)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                        
                        Text("Camina por el campus. El dispositivo te avisará cuando entres en la zona de una pista.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical, 25)
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                )
                .padding(.horizontal, 25)
                .padding(.bottom, 40)
            }
        }
    }
}
#Preview {
    // Si tu Pista no usa "CuerpoPista", simplemente pasa el objeto que tengas definido
    PantallaRadarView(
        controlador: ControladorAplicacion(),
        pistaActual: Pista(
            ubicacion: CLLocation(latitude: 31.678172, longitude: 106.410758),
            id: "pista_prueba",
            cuerpo: PistaInformacion(informacion: "Prueba") // Asegúrate de que esto coincida con tu modelo
        )
    )
}
