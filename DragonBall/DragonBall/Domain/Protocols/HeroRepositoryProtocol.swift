//
//  HeroRepositoryProtocol.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
protocol HerosRepositoryProtocol{
    func getHeros(filter: String) async -> [HerosModel]
}
