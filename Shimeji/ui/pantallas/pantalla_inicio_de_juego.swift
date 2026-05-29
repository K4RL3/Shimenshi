//
//  pantalla_test.swift
//  Shimeji
//
//  Created by Jose de la luz Orivate var
import SwiftUI

struct PantallaTest: View {
    var body: some View {
        // 1. Envolvemos toda la pantalla en un NavigationStack para habilitar el viaje a otra pantalla
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
                
                
                // ⚠️ AQUÍ ESTÁ EL CAMBIO: Textos en la parte superior
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
                    
                    // El Spacer ahora está ABAJO, empujando todo el bloque hacia arriba
                    Spacer() 
                }
                .padding(.top, 60) // Un margen superior para que no se pegue al borde del iPhone
                
                
                // Botón Inferior de Navegación
                VStack(spacing: 15) {
                    Spacer()
                    
                    // 2. El NavigationLink que desliza la pantalla hacia el Radar
                    NavigationLink(destination: Text("PantallaRadarView") // Reemplaza esto con tu PantallaRadarView()
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
}
