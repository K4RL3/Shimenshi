//
//  estado_planetas_desaparecidos.swift
//  Shimeji
//
//  Created by alumno on 4/24/26.
//

class PlanetasDesaparecidos: Estado{
    var descripcion: String = ""
    
    var posibles_estados: [String] = []
    

    var contexto: (any MaquinaEstadosGenerica)?
    static let nombre = "Planetas de23parecidos"
    
    func inicializar() {
        
    }
    
    func actualizar(_ tipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles ) {
        print("HOla desde planetas desaparecidos")
    }
    
    func finalizar() {
        
    }
    
    func reaccion(estimulo: String) {
        
    }
    
    
}


