//
//  servicio_agente.swift
//  Shimeji
//
//  Created by alumno on 5/6/26.
//

import FirebaseFirestore
import Combine

@Observable
class ServicioAgente{
    var peticion: Peticion? = nil
    //var peticion: [Peticion] = []
    
    private var bd = Firestore.firestore()
    
    func crear_peticion(contexto: Contexto, mensaje_del_usuario: String){
        print("hiiii \(#function)")
        
        let peticion = Peticion(
            id: UUID().uuidString,
            estado: .creacion,
            contexto: contexto,
            mensaje: mensaje_del_usuario,
            comando_a_ejecutar: nil,
            respuesta: nil,
        )
        do {
            var resultado_enviar_peticion = try bd.collection("peticiones").addDocument(from: peticion)
            print("el resultado de enviar la peticion \(resultado_enviar_peticion)")
        }
        catch {
            print("lol no le supiste \(error)")
        }
    }

    
    func enviar_peticion(){
        let contexto = Contexto(
            historia: "eres un chilango tipico, tus compas te desconosen y los gringos te confunden, por blanco",
            personalidad: "naco y estupido",
            acciones_disponibles: ["insultar","hablar fresa", "ser clasista"],
            estados_disponibles: ["neutral2", "agradable con gringos"],
            estado_emocional: "feliz por existir",
            estado_actual: "neutral2",
            descripcion: ""
        )
    }
}
