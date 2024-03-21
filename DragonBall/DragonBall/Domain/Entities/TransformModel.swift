//
//  TransformModel.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
struct Transformacione: Codable{
    var id: UUID?
    var name: String
    var descrption: String
    var photo:String
}
struct TransformationModelRequest: Codable {
    let id: UUID
}
