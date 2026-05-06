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
    //var peticion: Peticion? = nil
    var peticion: [Peticion] = []
    
    private var bd = Firestore.firestore()
    
    func obtener_actualizaciones(){
        bd.collection("mensajes").order(by: "timestamp").addSnapshotListener { snapshot, error in
            guard let documento = snapshot?.documents else {return}
            self.peticion = documento.compactMap{elemento in
                try? elemento.data(as: Peticion.self)
            }
        }
    }
    
    func enviar_peticion(){
        let contexto = Contexto(
            historia: "hola",
            personalidad: "hola2",
            acciones_disponibles: [],
            estados_disponibles: [],
            estado_emocional: ""
        )
        
        let peticion = Peticion(
            id: UUID().uuidString,
            estado: .creacion,
            contexto: contexto,
            mensaje: "lol",
            animacion: nil,
            comando_a_ejecutar: nil,
            respuesta: nil,
        )
        do {
            var resultado_enviar_peticion = try bd.collection("mensajes").addDocument(from: peticion)
            print("el resultado de enviar la peticion \(resultado_enviar_peticion)")
        }
        catch {
            print("lol no le supiste \(error)")
        }
    }
}
