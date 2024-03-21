//
//  AppState.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//


import Foundation
import Combine

enum LoginStatus{
    case none
    case success
    case error
    case notValidate
}

//ViewModel

final class LoginViewModel{
    
    //estado del login
    @Published var statusLogin : LoginStatus = .none
    
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    
    //funcion de login
    func loginApp(user: String, pass: String){
        
        Task{
            if (await loginUseCase.loginApp(user: user, password: pass)){
                //login success
                self.statusLogin = .success
            } else {
                //login error
                self.statusLogin = .error
            }
        }
    }
    
    //evaluo autologin
    func validateControlLogin(){
        Task{
            if (await loginUseCase.validateToken()){
                //esta logado ya.
                self.statusLogin = .success
            } else {
                self.statusLogin = .notValidate
            }
        }
    }
    
    func closeSessionUser() {
        Task{
            await loginUseCase.logout()
            self.statusLogin = .none  //que vaya al login
            
        }
    }
    
    
    
}
