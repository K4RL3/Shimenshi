//
//  control_aplicacion.swift
//  Shimeji
//
//  Created by alumno on 4/15/26.
//

import SwiftUI
import RealityKit
import ARKit
import FirebaseFirestore

@Observable
@MainActor
public class ControladorAplicacion {
    public var raiz_escena: Entity = Entity()
    public var estado: EstadosAplicacion = .inciando
    public var pantallas_emergentes: [PantallasDisponibles] = []
    
    // --- RASTREO DEL PROGRESO Y DIÁLOGOS ---
    public var piezasEncontradas: Int = 0
    public var totalPiezas: Int = 5
    public var mensajeCapi: String = "¡Hola! Soy Capi. Ayúdame a encontrar las piezas de mi amigo Ajolote en la UACJ."
    // ---------------------------------------

    var entidades_ancla: [AnchorEntity] = []
    var maquinas_de_estados: [MaquinaEstadosGenerica] = [MaquinaEstadosCapi()]
    
    init() {
        for indice in 0...maquinas_de_estados.count - 1 {
            maquinas_de_estados[indice].controlador_general = self as ProcesarComandos
        }
        
        self.estado = .todo_cargado
    }
    
    // Función para cuando se encuentra una pieza (vía AR o botón)
    func piezaEncontrada() {
        if piezasEncontradas < totalPiezas {
            piezasEncontradas += 1
            
            // Actualizamos el diálogo según el progreso
            switch piezasEncontradas {
            case 1:
                mensajeCapi = "¡Increíble! Encontramos una patita. Sigamos buscando cerca del edificio A."
            case 2:
                mensajeCapi = "¡Mira, las branquias! Ya casi recupera su forma el pequeño."
            case 5:
                mensajeCapi = "¡Lo logramos! El Ajolote está completo. ¡Eres el mejor guía de la UACJ!"
            default:
                mensajeCapi = "¡Otra pieza! Siento que mi amigo está cada vez más cerca de estar bien."
            }
            
            actualizar_estados(.notificacion, .realizar_accion)
            print("¡Pieza \(piezasEncontradas) de \(totalPiezas) recolectada!")
        }
    }

    func actualizar_estados(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        for maquina in maquinas_de_estados {
            maquina.actualizar(tipo_interaccion, interaccion)
        }
    }
    
    func generar_contexto() -> Contexto {
        return maquinas_de_estados[0].generar_contexto_textual()
    }
}
