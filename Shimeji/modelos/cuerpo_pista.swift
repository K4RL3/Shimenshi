//
//  cuerpo_pista.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 20/05/26.
//

enum TiposDePista{
    case informacion
    case interactiva
}

protocol CuerpoPista{
    var tipo: TiposDePista { get set }
    var informacion: String { get set }
}

struct PistaInformacion: CuerpoPista{
    var tipo = TiposDePista.informacion
    
    var informacion: String
}

struct PistaInteractuable: CuerpoPista{
    var tipo = TiposDePista.interactiva
    
    var informacion: String
    
    var interacciones: [BotonPista]
}


