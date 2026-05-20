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

    var body: some View {
        ZStack {
            RealityView { contenido in
                contenido.camera = .spatialTracking
                
                // 1. MURAL DEL A -> BRANQUIAS
                let anclaMural = AnchorEntity(.image(group: "imagenes", name: "branquias_ajolote"))
                anclaMural.addChild(crearCajaGuia(color: .red))
                contenido.add(anclaMural)

                // 2. CANCHA DE PADDEL -> PATA DELANTERA
                let anclaPadel = AnchorEntity(.image(group: "imagenes", name: "patas_ajolote"))
                anclaPadel.addChild(crearCajaGuia(color: .blue))
                contenido.add(anclaPadel)

                // 3. PUERTA DEL W ->  LLANTAS EN EL SUELO
                let anclaPuertaW = AnchorEntity(.image(group: "imagenes", name: "llantas_marca"))
                anclaPuertaW.addChild(crearCajaGuia(color: .purple))
                contenido.add(anclaPuertaW)

                // 4. PUERTA DEL D -> COLA
                let anclaPuertaD = AnchorEntity(.image(group: "imagenes", name: "cola_ajolote"))
                anclaPuertaD.addChild(crearCajaGuia(color: .orange))
                contenido.add(anclaPuertaD)
            }
            .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ _ in
                controlador.piezaEncontrada()
            }))
            .background(Color.black)

            VistaPrincipal()
        }
    }

    func crearCajaGuia(color: UIColor) -> ModelEntity {
        return ModelEntity(mesh: .generateBox(size: 0.1), materials: [SimpleMaterial(color: color, isMetallic: true)])
    }
}


#Preview {
    SeguimientoImagenes()
        .environment(ControladorAplicacion())
}
