//
//  personaje_feliz.swift
//  Shimeji
//
//  Created by alumno on 5/11/26.
//

class PersonajeTriste: Estado{
    var contexto: (any MaquinaEstadosGenerica)? = nil
    
    var descripcion: String = "Está algo triste, busca consuelo y ayuda."
    
    var posibles_estados: [String] = [PersonajeTriste.nombre]
    
    static var nombre: String = "Personaje en tristeza."
    
    func inicializar() { }
    
    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        
    }
    
    func finalizar() { }
    
    func reaccion(estimulo: String) { }
}
