//
//  HeroModel.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
struct HerosModel: Codable {
    let id: UUID
    let favorite: Bool
    let description: String
    let photo: String
    let name: String
    
    func getFullName() -> String {
        return "\(name)  $"
    }
}


struct HerosModelRequest: Codable {
    let name: String
}
