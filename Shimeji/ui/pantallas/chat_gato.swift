//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

//import SwiftUI
//
//struct ChatView: View {
//    @Environment(ControladorAplicacion.self) var controlador
//    @State var entidad_ia = ServicioAgente()
//    
//    static let nombre = PantallasDisponibles.platicar
//    
//    @State var mensaje_a_enviar: String = ""
//    
//    var body: some View {
//        VStack{
//            Text("La respuesta del agente fue: \(entidad_ia.peticion?.respuesta)")
//            
//            TextField("Cuentame que enviar", text: $mensaje_a_enviar)
//              
//            Button{
//                entidad_ia.crear_peticion(contexto: controlador.generar_contexto(),  mensaje_del_usuario: mensaje_a_enviar)
//            } label: {
//                Text("Pulsame para enviar cosas")
//            }
//            
//        }
//        .background(Color.red)
//    }
//}
//
//#Preview {
//    ChatView()
//        .environment(ControladorAplicacion())
//}





//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

//
//  chat_gato.swift
//  Shimeji
//
//  Created by alumno on 5/4/26.
//

import SwiftUI

enum AgenteIA: Int {
    case capi = 0 // Índice 0 en tu arreglo maquinas_de_estados
    case ajo = 1  // Índice 1 en tu arreglo maquinas_de_estados
    
    var nombre: String {
        switch self {
        case .capi: return "Capi"
        case .ajo: return "Ajo"
        }
    }
}

struct ChatView: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var entidad_ia = ServicioAgente()
    
    @State var mensaje_a_enviar: String = ""
    @State var estaPensando: Bool = false
    @State private var animarIA = false
    
    // El estado guarda directamente el índice de la máquina que vamos a usar
    @State private var agenteSeleccionado: AgenteIA = .capi
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue.opacity(0.8)]),
                           startPoint: .topLeading, endPoint: .bottomLeading)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // CABECERA
                VStack(spacing: 8) {
                    Text("ASISTENTE IA ACTIVO")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color.yellow)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
                    
                    Text(estaPensando ? "Procesando respuesta..." : "Conectado a la red")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // ANIMACIÓN CENTRAL
                ZStack {
                    Circle().fill(Color.white.opacity(0.2)).frame(width: 100, height: 100)
                    Circle()
                        .stroke(agenteSeleccionado == .capi ? Color.orange.opacity(0.8) : Color.cyan.opacity(0.8), lineWidth: 3)
                        .frame(width: 100, height: 100)
                        .scaleEffect(animarIA ? 1.5 : 1.0)
                        .opacity(animarIA ? 0.0 : 1.0)
                        .animation(estaPensando ? Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false) : .default, value: animarIA)
                    
                    Image(systemName: agenteSeleccionado == .capi ? "pawprint.fill" : "drop.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .onAppear {
                    animarIA = true
                }
                
                Spacer()
                
                // TARJETA DE ACCIONES
                VStack(spacing: 15) {
                    
                    // BOTONES DE SELECCIÓN DE IA
                    HStack(spacing: 15) {
                        Button(action: {
                            agenteSeleccionado = .capi
                            entidad_ia.peticion?.respuesta = ""
                        }) {
                            Text(AgenteIA.capi.nombre)
                                .fontWeight(.black)
                                .foregroundColor(agenteSeleccionado == .capi ? .white : .gray)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(agenteSeleccionado == .capi ? Color.orange : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            agenteSeleccionado = .ajo
                            entidad_ia.peticion?.respuesta = ""
                        }) {
                            Text(AgenteIA.ajo.nombre)
                                .fontWeight(.black)
                                .foregroundColor(agenteSeleccionado == .ajo ? .white : .gray)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(agenteSeleccionado == .ajo ? Color.cyan : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 5)
                    
                    // ÁREA DE RESPUESTA
                    ScrollView {
                        VStack {
                            if estaPensando {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: agenteSeleccionado == .capi ? .orange : .blue))
                                    .scaleEffect(1.2)
                                    .padding(.top, 10)
                                
                            } else if let respuesta = entidad_ia.peticion?.respuesta, !respuesta.isEmpty {
                                Text(respuesta)
                                    .font(.body).foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                
                            } else {
                                Text("Hablando con \(agenteSeleccionado.nombre). ¿En qué te puedo ayudar?")
                                    .font(.body).foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: 150)
                    
                    // ENTRADA DE TEXTO
                    TextField("Pregúntale algo a \(agenteSeleccionado.nombre)...", text: $mensaje_a_enviar)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    
                    // BOTÓN DE ENVIAR (🔥 LÓGICA PURA, SIN HACKS DE VISTA)
                    Button(action: {
                        guard !mensaje_a_enviar.isEmpty else { return }
                        estaPensando = true
                        
                        // 1. Accedemos directamente a la Máquina de Estados a través de su índice
                        let maquinaActiva = controlador.maquinas_de_estados[agenteSeleccionado.rawValue]
                        
                        // 2. Le pedimos a la Máquina de Estados que nos entregue su Contexto PURO
                        let contextoPuro = maquinaActiva.generar_contexto_textual()
                        
                        // 3. Enviamos el mensaje delegando todo a Firebase y LMS
                        entidad_ia.crear_peticion(contexto: contextoPuro, mensaje_del_usuario: mensaje_a_enviar)
                        
                        mensaje_a_enviar = ""
                    }) {
                        Text("Enviar Mensaje")
                            .fontWeight(.black).foregroundColor(.white)
                            .padding().frame(maxWidth: .infinity)
                            .background(agenteSeleccionado == .capi ? Color.orange : Color.cyan)
                            .cornerRadius(15)
                    }
                }
                .padding(.vertical, 25).padding(.horizontal, 15)
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.white).shadow(radius: 10))
                .padding(.horizontal, 25).padding(.bottom, 40)
            }
        }
        .onChange(of: entidad_ia.peticion?.respuesta) { _, nuevaRespuesta in
            if let res = nuevaRespuesta, !res.isEmpty {
                estaPensando = false
            }
        }
    }
}

#Preview {
    ChatView()
        .environment(ControladorAplicacion())
}
