//
//  TransfofrmRepository.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
// Real
final class TransformationsRepository: TransformationsRepositoryProtocol {
    func getTransformations(forHeroWithID id: UUID) async throws -> [Transformacione] {
        await network.getTransformations(forHeroWithID: id)
    }
    
    private var network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol = NetworkTransformations()) {
        self.network = network
    }
}

// Fake
final class TransformationsRepositoryFake: TransformationsRepositoryProtocol {
    func getTransformations(forHeroWithID id: UUID) async throws -> [Transformacione] {
        await network.getTransformations(forHeroWithID: id)
    }
    
    private var network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol = NetworkTransformationsFake()) {
        self.network = network
    }
}
