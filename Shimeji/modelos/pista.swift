//
//  pista.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 20/05/26.
//

import CoreLocation

struct Pista: Identifiable{
    let ubicacion: CLLocation
    var distancia_minima: Double = 25.0
    var distancia_maxima: Double = 100.0
    let id: String
    let cuerpo: CuerpoPista
    
    func calcular_porcentaje(ubicacion: CLLocation?) -> Double? {
        // 1. Guard let es más seguro que el if nil
        guard let ubicacion_actual = ubicacion else { return nil }
        
        let distancia_a_la_pista = ubicacion_actual.distance(from: self.ubicacion)
        
        // 2. Definimos el radio máximo de tu radar (2 km = 2000 metros)
        let radio_maximo: Double = 2000.0
        
        // 3. Si el usuario está más lejos de 2km, devolvemos 0%
        if distancia_a_la_pista > radio_maximo {
            return 0.0
        }
        
        // 4. Si el usuario está muy cerca (menor a la distancia mínima), devolvemos 100%
        if distancia_a_la_pista <= distancia_minima {
            return 100.0
        }
        
        // 5. Cálculo del porcentaje:
        // (Distancia recorrida / Rango total) * 100
        // Usamos el radio_maximo para que la escala sea sobre los 2km
        let rango_util = radio_maximo - distancia_minima
        let distancia_recorrida = radio_maximo - distancia_a_la_pista
        
        let porcentaje = (distancia_recorrida / rango_util) * 100.0
        
        return max(0.0, min(100.0, porcentaje)) // Asegura que esté siempre entre 0 y 100
    }
    
    func esta_en_rango(ubicacion: CLLocation?) -> Bool{
        if(ubicacion == nil){
            return false
        }
        
        let distancia_a_la_pista = ubicacion!.distance(from: self.ubicacion)
        
        if(distancia_a_la_pista > distancia_maxima){
            return false
        }
        
        return true
    }
    
    func puede_ser_recogida(ubicacion: CLLocation?) -> Bool{
        if(ubicacion == nil){
            return false
        }
        
        let distancia_a_la_pista = ubicacion!.distance(from: self.ubicacion)
        
        if(distancia_a_la_pista < distancia_minima){
            return true
        }
        
        return false
    }

}
