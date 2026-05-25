//
//  estado_generico.swift
//  Shimeji
//
//  Created by alumno on 4/20/26.
//
protocol Estado{
    var contexto: MaquinaEstadosGenerica? { get set }
    var descripcion: String { get set}
    var posibles_estados: [String] { get set}
    
    static var nombre: String { set get }
    
    func inicializar() -> Void
    
    func actualizar(_ ipo_interaccion: TiposDeInteraccion, _ interaccion: BotonesDisponibles) -> Void
    
    func finalizar() -> Void
    
    func reaccion(estimulo: String) -> Void
    
}

