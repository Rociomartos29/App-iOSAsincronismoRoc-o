//
//  LoginRepoitoryProtocol.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import Foundation

protocol LoginRespositoryProtocol {
    func loginApp(user: String, password: String) async -> String //devuelve el token JWT
}
