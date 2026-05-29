//
//  pantalla_radar.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 28/05/26.
//

import SwiftUI

struct PantallaRadarView: View {
    // Variable para controlar la animación de las ondas del radar
    @State private var animarRadar = false
    
    var body: some View {
        ZStack {
            // 1. Mismo fondo degradado para mantener la continuidad visual con la pantalla de inicio
            LinearGradient(gradient: Gradient(colors:[Color.cyan, Color.blue.opacity(0.7)]),
                           startPoint: .topLeading,
                           endPoint: .bottomLeading)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // 2. Título superior
                VStack(spacing: 5) {
                    Text("RASTREADOR ACTIVO")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color.yellow)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
                    
                    Text("Buscando rastro del Ajolote...")
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // 3. Animación de Radar (Círculos expansivos)
                ZStack {
                    // Círculo estático del centro
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    // Primera onda que se expande
                    Circle()
                        .stroke(Color.yellow.opacity(0.6), lineWidth: 3)
                        .frame(width: 80, height: 80)
                        .scaleEffect(animarRadar ? 3.5 : 1.0)
                        .opacity(animarRadar ? 0.0 : 1.0)
                    
                    // Segunda onda que se expande (con un color cyan para contrastar)
                    Circle()
                        .stroke(Color.cyan.opacity(0.8), lineWidth: 3)
                        .frame(width: 80, height: 80)
                        .scaleEffect(animarRadar ? 2.5 : 1.0)
                        .opacity(animarRadar ? 0.0 : 1.0)
                        // Le damos un pequeño retraso a esta onda para que se vea un efecto de "pulso"
                        .animation(Animation.easeOut(duration: 2.0).repeatForever(autoreverses: false).delay(0.5), value: animarRadar)
                    
                    // Icono central del radar
                    Image(systemName: "location.viewfinder")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .frame(height: 250)
                .onAppear {
                    // Arrancamos la animación infinita en cuanto aparece la pantalla
                    withAnimation(Animation.easeOut(duration: 2.0).repeatForever(autoreverses: false)) {
                        animarRadar = true
                    }
                }
                
                Spacer()
                
                // 4. Tarjeta de Instrucciones (blanca para resaltar como tu botón)
                VStack(spacing: 15) {
                    Text("NUEVA PISTA DETECTADA")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.cyan)
                    
                    Text("Dirígete al Edificio V")
                        .font(.system(.title))
                        .fontWeight(.black)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("Busca la marca con el Signo de Exclamacion. Tu dispositivo te avisará cuando estés lo suficientemente cerca.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
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

struct PantallaRadarView_Previews: PreviewProvider {
    static var previews: some View {
        PantallaRadarView()
    }
}
