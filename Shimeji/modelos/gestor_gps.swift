import CoreLocation
import Observation // Mágia para que SwiftUI detecte cambios en tiempo real

@Observable // 🔥 IMPORTANTE: Esto le dice a SwiftUI que actualice la pantalla al caminar
class GestorGPS: NSObject, CLLocationManagerDelegate {
    public let locationManager = CLLocationManager()
    
    // Esta variable notificará al radar CADA VEZ que cambie
    var ubicacionActual: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        // Filtro para que no baile el GPS en interiores y ahorre batería
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 3.0 // Mínimo 3 metros de movimiento para reportar
        
        locationManager.requestWhenInUseAuthorization()
        
        // 🔥 ESTA ES LA LÍNEA CLAVE: Activa el rastreo CONSTANTE
        locationManager.startUpdatingLocation()
    }
    
    // 🔥 EL DELEGADO: Xcode llama a esta función automáticamente cada vez que te mueves
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let nuevaUbicacion = locations.last else { return }
        
        // Al actualizar esta variable, el radar se recalcula solo
        self.ubicacionActual = nuevaUbicacion
        
        // Pon este print para que verifiques en la consola de Xcode si se mueve constantemente
        print("📍 GPS en movimiento: \(nuevaUbicacion.coordinate.latitude), \(nuevaUbicacion.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Error de CoreLocation: \(error.localizedDescription)")
    }
}
