//
//  LoginUseCase.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import KcLibraryswift

protocol LoginUseCaseProtocol{
    var repo: LoginRespositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}


//implmentamos el caso de uso
final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRespositoryProtocol
    
    init(repo: LoginRespositoryProtocol = DefaultLoginRespository(Network: NetworkLogin())){
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
    
        let token = await repo.loginApp(user: user, password: password)
        
        //guardar token en KeyChain
        if token != "" {
            //login success
            KeyChainKC().saveKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            //login error
            KeyChainKC().deleteKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
        

    }
    
    func logout() async {
        //logout
        KeyChainKC().deleteKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if KeyChainKC().loadKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN) != "" {
            //tengo token
            return true
        } else {
            return false
        }
    }
    
    
}




final class LoginUseCaseFake: LoginUseCaseProtocol {
    var repo: LoginRespositoryProtocol
    
    init(repo: LoginRespositoryProtocol = DefaultLoginRespositoryFake()){
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
    
        let token = await repo.loginApp(user: user, password: password)
        
        //guardar token en KeyChain
        if token != "" {
            //login success
            KeyChainKC().saveKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            //login error
            KeyChainKC().deleteKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
        

    }
    
    func logout() async {
        //logout
        KeyChainKC().deleteKC(key: ConstantApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        true
    }
    
    
}
