//
//  LoginRepository.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//



import Foundation


//Real
final class DefaultLoginRespository: LoginRespositoryProtocol {
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol) {
        self.Network = Network
    }
  
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}

//Fake
final class DefaultLoginRespositoryFake: LoginRespositoryProtocol {
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol = NetworkLoginFake()) {
        self.Network = Network
    }
  
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}
