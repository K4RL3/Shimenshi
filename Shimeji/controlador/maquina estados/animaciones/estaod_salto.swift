//
//  estaod_salto.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//


class SaltoAnimacion: Estado{
    var contexto: (any MaquinaEstadosGenerica)? = nil
    
    static let nombre = "Salto"

    
    func inicializar() {
        print("HOla desde Saltillo Hermosillo \(#file)")
    }
    
    func actualizar(_ evento: String) {
        switch evento{
            default:
                print("HOla a todos desde el estado de Saltillo Guanajuatillo")
                contexto?.realizar_cambio_de_estado(a: PlanetasDesaparecidos.nombre)
        }
    }
    
    func finalizar() {}
    
    func reaccion(estimulo: String) {
    }
    
    
}
