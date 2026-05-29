import CoreLocation
import Foundation

let pistas = [
    // PISTA 1: Edificio V - TIPO: INFORMACIÓN
    Pista(
        ubicacion: CLLocation(latitude: 31.7425546, longitude: -106.4328811),
        id: "pista_1",
        cuerpo: PistaInformacion(
            informacion: "Signo de Interrogación (Edificio V). ¡El juego comienza aquí! Algo extraño pasó en IADA/IIT. Ve hacia las canchas de padel para investigar."
        )
    ),
    
    // PISTA 2: Cancha de Padel - TIPO: INTERACTIVA
    Pista(
        ubicacion: CLLocation(latitude: 31.742468, longitude: -106.432279),
        id: "pista_2",
        cuerpo: PistaInteractuable(
            informacion: "Signo de Admiración (Cancha de padel). Hay huellas extrañas en el suelo.",
            interacciones: [
                BotonPista(mensaje: "Seguir las huellas al Edificio B", conecta_con_pista: "pista_3"),
                BotonPista(mensaje: "Ignorar e ir a la caftería", conecta_con_pista: "pista_1")
            ]
        )
    ),
    
    // PISTA 3: Edificio B - TIPO: ACERTIJO 
    Pista(
        ubicacion: CLLocation(latitude: 31.742105, longitude: -106.432328),
        id: "pista_3",
        cuerpo: PistaAcertijo(
            informacion: "Patitas (Edificio B). Encontraste un rastro de huellas pequeñas.",
            pregunta: "¿Cuántos dedos tienen las patitas marcadas en el piso?",
            respuestaCorrecta: "4"
        )
    ),
    
    // PISTA 4: Edificio C - TIPO: INFORMACIÓN
    Pista(
        ubicacion: CLLocation(latitude: 31.741917, longitude: -106.432188),
        id: "pista_4",
        cuerpo: PistaInformacion(
            informacion: "Cola (Edificio C). ¡Las huellas llevan a esta marca! Parece la cola de un animal. La criatura debió moverse hacia el Edificio W."
        )
    ),
    
    // PISTA 5: Edificio W - TIPO: INTERACTIVA
    Pista(
        ubicacion: CLLocation(latitude: 31.743768, longitude: -106.432336),
        id: "pista_5", // Corregido, antes decía pista_4
        cuerpo: PistaInteractuable(
            informacion: "Cabeza (Edificio W). Aquí está el dibujo de la cabeza. Todo apunta a que la criatura intentó salir de IADA.",
            interacciones: [
                BotonPista(mensaje: "Correr a la entrada de IADA/IIT", conecta_con_pista: "pista_6")
            ]
        )
    ),
    
    // PISTA 6: Entrada IADA/IIT - TIPO: ACERTIJO
    Pista(
        ubicacion: CLLocation(latitude: 31.742644, longitude: -106.433444),
        id: "pista_6",
        cuerpo: PistaAcertijo(
            informacion: "Entrada de IADA IIT. Aquí está la marca de atropello. ¡Es el final del rastro!",
            pregunta: "¿Qué objeto detuvo a la criatura?",
            respuestaCorrecta: "carro"
        )
    )
]
