//
//  estaod_salto.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//

class SaltoAnimccion: Estado {
    var contexto: (any MaquinaEstadosGenerico)? = nil
    
    static let nombre = "Salto"
    
    
    func inicializar() {
        print("HOla desde Saltillo Hermosillo \(#file)")
    }
    
    func actualizar(_ evento: String) {
        switch evento{
                   default:
                       print("HOla a todos desde el estado de Saltillo Guanajuatillo")
                       contexto?.realizarr_cambio_estado(a: PlanetasDesaparecidos.nombre)
        }

    }
    
    func finalizar() {
        <#code#>
    }
    
    func reacion(estimulo: String) {}
    
    
}
