//
//  LogingRepository.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import Foundation

// Caso Real

final class LoginRepository: LoginRepositoryProtocol{

    private var netWork: NetworkLoginProtocol
    
    init(netWork: NetworkLoginProtocol) {
        self.netWork = netWork
    }
    func loginApp(user: String, password: String) async -> String {
        return await netWork.loginApp(user: user, password: password)
    }
}
final class LoginRespositoryFake: LoginRepositoryProtocol {
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol = NetworkLoginFake()) {
        self.Network = Network
    }
  
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}
