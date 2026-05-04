//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

import SwiftUI

struct ChatView: View {
    @State var sesion_chat = ServicioChat()
    @State var msj_a_enviar: String = ""
    
    var body: some View {
        VStack {
            ForEach(sesion_chat.mesnajes){
                mensaje in
                Text("el mensaje es : \(mensaje.texto) de parte de \(mensaje.remitente)")
            }
            
            TextField("cuentame que enviar", text: $msj_a_enviar)
            
            Button{
                sesion_chat.enviar_msj(texto: msj_a_enviar)
                msj_a_enviar = ""
            } label: {
                Text("Puslsame para publicar")
            }
        }
        .onAppear {
            sesion_chat.obtener_msj()
        }
    }
}

#Preview {
    ChatView()
}
