//
//  LoginUseCase.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import Foundation
import KcLibraryswift

protocol LoginUseCaseProtocol{
    var repo: LoginRepositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}


//implmentamos el caso de uso
final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = LoginRepository(netWork: NetworkLogin())){
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
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = LoginRespositoryFake()){
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
