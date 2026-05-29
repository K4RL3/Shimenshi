//
//  pantalla_test.swift
//  Shimeji
//
//  Created by Jose de la luz Orivate var
import SwiftUI
import CoreLocation
import RealityKit
import mundo_virtual

struct PantallaTest: View {
    // 1. Jalamos el controlador maestro para podérselo pasar al radar
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo Degradado
                LinearGradient(gradient: Gradient(colors:[Color.cyan, Color.blue.opacity(0.7)]),
                               startPoint: .topLeading,
                               endPoint: .bottomLeading)
                .ignoresSafeArea()
                
                // Huellas decorativas del fondo
                VStack {
                    HStack {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color.white.opacity(0.2))
                            .rotationEffect(Angle(degrees: -20))
                        Spacer()
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color.white.opacity(0.15))
                            .rotationEffect(Angle(degrees: 15))
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color.white.opacity(0.15))
                            .rotationEffect(Angle(degrees: 30))
                        Spacer()
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color.white.opacity(0.2))
                            .rotationEffect(Angle(degrees: -10))
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.vertical, 50)
                
                
                // Títulos centrales perfectamente alineados
                VStack(spacing: 30) {
                    VStack {
                        Text("Capi al Rescate")
                            .font(.system(.largeTitle))
                            .fontWeight(.black)
                            .foregroundColor(Color.yellow)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        Text("En busca del Ajolote")
                            .font(.system(.title2))
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
                    }

                    HStack(spacing: 40) {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 45))
                            .foregroundColor(Color.white)
                    }
                }
                
                
                // Botón Inferior de Navegación
                VStack(spacing: 15) {
                    Spacer()
                    
                    // 2. Aquí conectamos la vista pasándole el controlador y la Pista 1 (índice 0)
                    NavigationLink(destination: PantallaNarrativaView(alFinalizarHistoria: {}
                        // Inicia buscando la primera pista de tu lista
                    )
                    .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso
                    ) {
                        Text("Empezar")
                            .font(.system(.title))
                            .fontWeight(.black)
                            .foregroundColor(Color.cyan)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                            )
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    PantallaTest()
        .environment(ControladorAplicacion()) // Necesario para que el Preview no crashee
}
