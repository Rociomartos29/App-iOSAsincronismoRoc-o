//
//  NetworkTransformation.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import KcLibraryswift

protocol NetworkTransformationsProtocol{
    func getTransformations(filter: UUID) async -> [Transformacione]
    
}


final class NetworkTransformations: NetworkTransformationsProtocol{
   
    
    func getTransformations(filter: UUID) async -> [Transformacione] {
        var modelReturn = [Transformacione]()
        let urlCad = "\(ConstantApp.CONST_API_URL)\(Endpoints.transformation.rawValue)"
        var request = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(TransformationModelRequest(id: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        let tokenJWT = KeyChainKC().loadKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN)
        
        if let token = tokenJWT{
            request.addValue("Bearer\(token)", forHTTPHeaderField: "Authorization")
        }
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCESS {
                    modelReturn = try! JSONDecoder().decode([Transformacione].self, from: data)
                }
            }
            
        } catch {
            
        }
        return modelReturn
    }
}

final class NetworkTransfotmationsFake: NetworkTransformationsProtocol {
    func getTransformations(filter: UUID) async -> [Transformacione] {
        let model1 = Transformacione(id: UUID(), name: "1. Oozaru – Gran Mono", descrption: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru", photo:  "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")
    
      
      
        
       return [model1]
       
    }
}
