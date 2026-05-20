//
//  vista_principal.swift
//  Shimeji
//
//  Created by alumno on 5/20/26.
//

import SwiftUI

struct VistaPrincipal: View {
    // Esto "atrapa" el controlador que ya creaste en ShimejiApp
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        ZStack {
            // Capa de la interfaz sobre la cámara
            VStack {
                // 1. Barra de Progreso Superior
                HStack {
                    Text("Piezas del Ajolote")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.bold) // Corregido para evitar el error de inferencia
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Muestra el progreso real del controlador
                    Text("\(controlador.piezasEncontradas) / \(controlador.totalPiezas)")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold) // Corregido para evitar error
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color(red: 1.0, green: 0.8, blue: 0.9)) // Rosa Pastel
                        .cornerRadius(20)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding()

                Spacer()

                // 2. Cuadro de diálogo de Capi (CON AVATAR)
                HStack(spacing: 15) {
                    // Avatar de Capi
                    ZStack {
                        Circle()
                            .fill(Color.pink.opacity(0.1))
                            .frame(width: 60, height: 60)
                        
                        // Icono temporal de una carita (luego lo cambias por tu imagen)
                        Image(systemName: "face.smiling.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.pink.opacity(0.4))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CAPI")
                            .font(.caption)
                            .fontWeight(.bold) // Corregido: fuera del constructor de font
                            .foregroundColor(.purple.opacity(0.6))
                        
                        Text(controlador.mensajeCapi)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.black.opacity(0.8))
                            // Permite que el texto crezca si el mensaje es largo
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.85))
                .cornerRadius(25)
                .padding(.horizontal)

                // 3. Botón de interacción
                Button(action: {
                    // Simulamos que encontramos una pieza al tocar el botón
                    controlador.piezaEncontrada()
                    controlador.actualizar_estados(.boton, .realizar_accion)
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.7, green: 0.85, blue: 1.0)) // Azul Pastel
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "hand.tap.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
#Preview {
    VistaPrincipal()
        .environment(ControladorAplicacion())
}
