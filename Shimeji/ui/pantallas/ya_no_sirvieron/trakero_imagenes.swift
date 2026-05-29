//
//  trakero_imagenes.swift
//  Shimeji
//
//  Created by alumno on 4/27/26.
//

import SwiftUI
import RealityKit
import mundo_virtual

struct SeguimientoImagenes: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    // Recibimos la pista desde el Radar
    var indicePista: Int = 0
    
    var body: some View {
        ZStack {
            RealityView { contenido in
                contenido.camera = .spatialTracking
                
                let ancla = AnchorEntity(.image(group: "imagenes", name: "bnuy"))
                contenido.add(ancla)

                if let escena_rc = try? await Entity(named: "esenas/escena1", in: MundoVirtual) {
                        ancla.addChild(escena_rc)
                }else {
                    fatalError("error")
                }
            }
            .onAppear {
                // En lugar de pasarle un String quemado, le pasamos la propiedad del modelo
                controlador.maquinas_de_estados[0].realizar_cambio_de_estado(a: PersonajeFeliz.nombre)
                
                let pistaEncontrada = pistas[indicePista]
                print("El radar abrió la cámara automáticamente. La IA sabe que estamos en: \(pistaEncontrada.cuerpo.informacion)")
            }
            
            // Capa Narrativa en Voz en Off
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Voz en off:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    Text("«Las huellas me trajeron hasta aquí. Solo necesito enfocar la marca amarilla...»")
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.75))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea()
        .background(Color.black)
    }
}

/*#Preview {
    SeguimientoImagenes()
        .environment(ControladorAplicacion())
}*/

