//
//  controlador_app.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

import FirebaseFirestore
import Combine

@Observable
class ServicioChat{
    var mesnajes:[Mensaje] = []
    private var bd = Firestore.firestore()
    
    func obtener_msj(){
        bd.collection("mensajes").order(by: "timestamp").addSnapshotListener { snapshot, error in
            guard let documento = snapshot?.documents else {return}
            self.mesnajes = documento.compactMap{elemento in
                try? elemento.data(as: Mensaje.self)
            }
        }
    }
    
    func enviar_msj(texto: String){
        let mesnaje = Mensaje(
            id: UUID().uuidString,
            texto: texto,
            remitente: "yo",
            timestamp: Date()
        )
        do {
            _ = try bd.collection("mensajes").addDocument(from: mesnaje)
        }
        catch {
            print("lol no le supiste \(error)")
        }
    }
}
