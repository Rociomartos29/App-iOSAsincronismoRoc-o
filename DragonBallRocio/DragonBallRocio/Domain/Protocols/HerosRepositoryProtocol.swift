//
//  HerosRepositoryProtocol.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import Foundation
protocol HerosRepositoryProtocol{
    func getHeros(filter: String) async -> [HerosModel]
}
