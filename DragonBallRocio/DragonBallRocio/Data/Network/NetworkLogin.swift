//
//  NetworkLogin.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import Foundation
protocol NetworkLoginProtocol{
    func loginApp(user: String, password: String) async -> String
}
final class NetworkLogin: NetworkLoginProtocol{
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = ""
        
        let urlCad = "\(ConstantApp.CONST_API_URL)\(Endpoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)
        
        var segCredentials: String = ""
        
        if let  credentials = encodeCredentials{
            segCredentials = "Basic\(credentials)"
        }
        
        //Creamos la Request
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredentials, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse{
                if resp.statusCode == HTTPResponseCodes.SUCESS{
                    tokenJWT = String(decoding: data, as: UTF8.self)
                }
            }
        }catch{
            tokenJWT = ""
            
        }
        return tokenJWT
    }
}

final class NetworkLoginFake: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        UUID().uuidString
    }
}
