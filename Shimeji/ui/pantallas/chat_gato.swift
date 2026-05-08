//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

import SwiftUI

struct ChatView: View {
    @State var sesion_chat = ServicioChat()
    @State var sesion_agente = ServicioAgente()
    @State var msj_a_enviar: String = ""
    
    var body: some View {
        VStack {
            ForEach(sesion_chat.mesnajes){
                mensaje in
                Text("el mensaje es : \(mensaje.texto) de parte de \(mensaje.remitente)")
            }
            //Text("el naco y estupido dijo: \(sesion_agente.peticion?.respuesta)")
            
            
            TextField("cuentame que enviar", text: $msj_a_enviar)
            
            Button{
                sesion_agente.enviar_peticion()
                
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
