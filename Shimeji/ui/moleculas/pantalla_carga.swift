//
//  pantalla_carga.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 26/05/26.
//

import SwiftUI

struct PantallaCarga: View {

    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Color.black)
            VStack {
                Image(systemName: "moonphase.waxing.gibbous")
                    .font(.largeTitle)
                    .foregroundStyle(Color.red)
                    .symbolEffect(.breathe)
                
                Text("Cargando...")
                    .fontDesign(.rounded)
                    .font(.headline)
                    .foregroundStyle(Color.red)
                    .symbolEffect(.breathe)
                    .padding(2)
            }
        }
    }
}

#Preview {
    PantallaCarga()
        .environment(ControladorAplicacion())
}
