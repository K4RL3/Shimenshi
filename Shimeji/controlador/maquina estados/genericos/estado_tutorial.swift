//
//  estado_tutorial.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 26/05/26.
//

class CapiSaludoTutorial: Estado{
    
    var contexto: (any MaquinaEstadosGenerica)?
    
    var descripcion: String = ""
    
    var posibles_estados: [String] = []
    
    static var nombre: String = "CapiSaludoTutorialPrimero"
    
    func inicializar() {
        print("Inicia estado del tutorial.")
    }
    
    func actualizar(_ ipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) {
        print("Estado actual: Tutorial")
        
        switch evento{
        default:
            print("Tutorial: Terminado")
                contexto?.enviar_peticion(Comando(tipo: .activar_animacion, carga_util: "caminar_a_centro_saludo"))
        }
    }
    
    func finalizar() {
        <#code#>
    }
    
    func reaccion(estimulo: String) {
        <#code#>
    }
    
    
}
