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
    
    private var base_de_datos = Firestore.firestore()
    
    func obtener_actualizaciones_de_la_peticion(id: String){
        base_de_datos.collection("peticiones/\(id)")
            .addSnapshotListener { snapshot, error in
                guard let documento = snapshot?.documents else { return }
                self.peticion = documento.compactMap{ elemento in try? elemento.data(as: Peticion.self)
                }
        }
    }
    
    func crear_peticion(contexto: Contexto, mensaje_del_usuario: String){

        let peticion = Peticion(
            id: UUID().uuidString,
            estado: .creacion,
            contexto: contexto,
            mensaje: mensaje_del_usuario,
            comando_a_ejecutar: nil,
            respuesta: nil,
        )
        do {
            var resultado_enviar_peticion = try base_de_datos.collection("peticiones").addDocument(from: peticion)
            
            resultado_enviar_peticion.addSnapshotListener{ snapshot, error in
                guard let snapshot = try? snapshot?.data(as: Peticion.self) else { return }
                self.peticion = snapshot
            }
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
            estado_emocional: "feliz por existir"
        )
        
    }
}
