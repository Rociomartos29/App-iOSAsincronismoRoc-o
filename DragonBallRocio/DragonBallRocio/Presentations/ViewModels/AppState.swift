//
//  AppState.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
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
    
   //Estado del Login
    @Published var statusLogin: LoginStatus = .none
    
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    func loginApp(user: String, pass: String){
        Task{
            if (await loginUseCase.loginApp(user: user, password: pass)){
                self.statusLogin = .success
            }else{
                self.statusLogin = .notValidate
            }
        }
    }
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
    func closeSessionUser(){
        Task{
            await loginUseCase.logout()
            self.statusLogin = .none
        }
    }
}
