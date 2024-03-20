//
//  DetailsRepository.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 20/3/24.
//

import Foundation
protocol HeroDetailsServiceProtocol {
    func getHeroDetails(heroID: String, completion: @escaping (Result<Detalles, Error>) -> Void)
}

// Implementación del servicio
final class HeroDetailsService: HeroDetailsServiceProtocol {
    func getHeroDetails(heroID: String, completion: @escaping (Result<Detalles, Error>) -> Void) {
        // Construimos la URL para obtener los detalles del héroe con el ID proporcionado
        guard let url = URL(string: "\(ConstantApp.CONST_API_URL)\(Endpoints.heros.rawValue)" + heroID) else {
            completion(.failure(NSError(domain: "HeroDetailsService", code: 400, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }
        
        // Creamos una tarea de URLSession para realizar la solicitud HTTP GET
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Manejamos errores de red
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Verificamos si la respuesta es un HTTPURLResponse válido
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "HeroDetailsService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Respuesta de red inválida"])))
                return
            }
            
            // Verificamos el código de estado HTTP para determinar si la solicitud fue exitosa
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "HeroDetailsService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error de red: \(httpResponse.statusCode)"])))
                return
            }
            
            // Parseamos los datos JSON para obtener los detalles del héroe
            do {
                guard let data = data else {
                    completion(.failure(NSError(domain: "HeroDetailsService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Datos vacíos"])))
                    return
                }
                
                let decoder = JSONDecoder()
                let heroDetails = try decoder.decode(Detalles.self, from: data)
                completion(.success(heroDetails))
            } catch {
                completion(.failure(error))
            }
        }.resume() // Reanudamos la tarea de URLSession
    }
}
