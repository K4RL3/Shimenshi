//
//  gestor_gps.swift
//  Shimeji
//
//  Created by Jose de la luz Olivares Gandara on 28/05/26.
//

import CoreLocation
import SwiftUI

@Observable
public class GestorGPS: NSObject, CLLocationManagerDelegate {
    // Solo publicamos la coordenada en crudo
    public var ubicacionActual: CLLocation? = nil
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Permite actualizaciones frecuentes para el radar
        locationManager.distanceFilter = 1.0
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Cada vez que el usuario da un paso, actualizamos la variable
        self.ubicacionActual = locations.last
    }
}
