//
//  TransformRepositoryProtocol.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
protocol TransformationsRepositoryProtocol {
    func getTransformations(forHeroWithID id: UUID) async throws -> [Transformacione]
}
