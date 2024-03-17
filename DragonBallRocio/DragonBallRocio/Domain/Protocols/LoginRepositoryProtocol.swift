//
//  LoginRepositoryProtocol.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import Foundation
protocol LoginRepositoryProtocol{
    func loginApp(user:String, password: String) async -> String
    
}
