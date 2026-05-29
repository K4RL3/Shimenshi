////
////  servicio_agente.swift
////  Shimeji
////
////  Created by alumno on 5/6/26.
////
//
//import FirebaseFirestore
//import Combine
//
//@Observable
//class ServicioAgente{
//    var peticion: Peticion? = nil
//    //var peticion: [Peticion] = []
//    
//    private var base_de_datos = Firestore.firestore()
//    
//    func crear_peticion(contexto: Contexto, mensaje_del_usuario: String){
//        print("hiiii \(#function)")
//        
//        let peticion = Peticion(
//            id: UUID().uuidString,
//            estado: .creacion,
//            contexto: contexto,
//            mensaje: mensaje_del_usuario,
//            comando_a_ejecutar: nil,
//            respuesta: nil,
//        )
//        do {
//            var resultado_enviar_peticion = try base_de_datos.collection("peticiones").addDocument(from: peticion)
//            print("el resultado de enviar la peticion \(resultado_enviar_peticion)")
//        }
//        catch {
//            print("lol no le supiste \(error)")
//        }
//    }
//}
import FirebaseFirestore
import Observation

@Observable
class ServicioAgente {
    var peticion: Peticion? = nil
    private var base_de_datos = Firestore.firestore()
    private var listener: ListenerRegistration? = nil // 🔥 NUEVO: El escuchador
    
    func crear_peticion(contexto: Contexto, mensaje_del_usuario: String) {
        let nuevaPeticion = Peticion(
            id: UUID().uuidString,
            estado: .creacion,
            contexto: contexto,
            mensaje: mensaje_del_usuario,
            comando_a_ejecutar: nil,
            respuesta: nil
        )
        
        do {
            // Guardamos en Firebase
            try base_de_datos.collection("peticiones").document(nuevaPeticion.id).setData(from: nuevaPeticion)
            
            // 🔥 ESCUCHAMOS LOS CAMBIOS DE ESTA PETICIÓN ESPECÍFICA
            iniciarEscucha(id: nuevaPeticion.id)
            
        } catch {
            print("❌ Error al enviar: \(error)")
        }
    }
    
    private func iniciarEscucha(id: String) {
            listener?.remove()
            
            listener = base_de_datos.collection("peticiones").document(id)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else { return }
                    
                    // Usamos un bloque do-catch en lugar de try? para ver los errores
                    do {
                        let peticionActualizada = try document.data(as: Peticion.self)
                        
                        // Solo actualizamos en el hilo principal para que SwiftUI reaccione
                        DispatchQueue.main.async {
                            self.peticion = peticionActualizada
                        }
                        
                    } catch {
                        print("⚠️ SWIFT NO PUDO LEER EL DOCUMENTO DE FIREBASE:")
                        print("Error: \(error.localizedDescription)")
                        // Esto te ayudará a saber si Python le quitó un campo o le puso un tipo de dato equivocado
                    }
                }
        }
    // Limpiamos al destruir la clase
    deinit {
        listener?.remove()
    }
}
