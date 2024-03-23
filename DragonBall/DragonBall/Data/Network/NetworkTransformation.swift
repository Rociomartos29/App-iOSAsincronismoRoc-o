//
//  NetworkTransformation.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import KcLibraryswift
protocol NetworkTransformationsProtocol {
    func getTransformations(forHeroWithID id: UUID) async -> [Transformacione]
}

final class NetworkTransformations: NetworkTransformationsProtocol {
    func getTransformations(forHeroWithID id: UUID) async -> [Transformacione] {
        var transformations = [Transformacione]()
            
         // Construye la URL para la solicitud
         guard let url = URL(string: "\(ConstantApp.CONST_API_URL)\(Endpoints.transformation.rawValue)") else {
             return transformations
         }
            
         // Configura la solicitud HTTP
         var request = URLRequest(url: url)
         request.httpMethod = HTTPMethods.post
         
         // Codifica el ID del héroe en el cuerpo de la solicitud
         request.httpBody = try? JSONEncoder().encode(TransformationModelRequest(id: id))
         request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
         print("Creating request with URL:", request.url ?? "No URL")
         print("HTTP Method:", request.httpMethod ?? "No HTTP Method")
         
         // Agrega el token JWT si está disponible
         if let tokenJWT = KeyChainKC().loadKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN) {
             request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
         }
         
         do {
             // Realiza la solicitud HTTP y obtiene los datos de la respuesta
             let (data, response) = try await URLSession.shared.data(for: request)
             
             // Verifica si la respuesta es un éxito (código de estado 200)
             if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HTTPResponseCodes.SUCESS {
                 print("Received response with status code:", httpResponse.statusCode)
                 // Decodifica los datos en un array de objetos Transformation
                 transformations = try JSONDecoder().decode([Transformacione].self, from: data)
             }
         } catch {
             // Maneja los errores
             print("Error fetching transformations: \(error)")
         }
         
         return transformations
     }
}

final class NetworkTransformationsFake: NetworkTransformationsProtocol {
    func getTransformations(forHeroWithID id: UUID) async -> [Transformacione] {
        // Aquí puedes devolver datos falsos para pruebas o situaciones de error
        let model1 = Transformacione(id: UUID(), name: "1. Oozaru – Gran Mono", description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")
        return [model1]
    }
}
