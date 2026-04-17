//
//  control_aplicacion.swift
//  Shimeji
//
//  Created by alumno on 4/15/26.
//

import SwiftUI
import RealityKit
import mundo_virtual

@Observable
@MainActor
public class ControladorAplicacion{
    /// public var escenario: Entity? = nil
    
    public var raiz_escena: Entity = Entity()
    
    public var estado: EstadosAplicacion = .iniciando
    
    private var planetas_cargados: [Entity] = []
    
     var historial_comandos: [Comando] = []
    
    init(){
        Task.detached(priority: .high){
            await self.cargar_planetas()
        }
    }
    func cargar_planetas() async {
        defer{
            estado = .todo_cargado
        }
        
        var contador_de_bucle_for = 0
        
        for planeta in planetas{
            guard let planeta = try? await Entity(named: planeta, in: MundoVirtual) else {
                fatalError("NO SE HA PODIDO CARGAR EL PLANETA EN \(#function) con planeta \(planeta)")
            }
            planeta.position.y = Float(contador_de_bucle_for / 8) * 0.2
            planeta.position.x = Float(contador_de_bucle_for % 3) * 0.2

            
            raiz_escena.addChild(planeta)
            planetas_cargados.append(planeta)
            
            contador_de_bucle_for += 1
        }
        
    }
    func alejar_planetas(legitud: Float){
        for planeta_cargado in planetas_cargados {
            planeta_cargado.position.z = legitud
        }
    }
    
}
