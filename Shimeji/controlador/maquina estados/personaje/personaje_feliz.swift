//
//  personaje_feliz.swift
//  Shimeji
//
//  Created by alumno on 5/11/26.
//

class PersonajeFeliz: Estado{
    var contexto: (any MaquinaEstadosGenerica)? = nil
    
    var descripcion: String = "Está feliz y entusiasmado."
    
    var posibles_estados: [String] = [PersonajeNeutro.nombre]
    
    static var nombre: String = "Personaje en felicidad."
    
    func inicializar() { }
    
    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        
    }
    
    func finalizar() { }
    
    func reaccion(estimulo: String) { }
}
