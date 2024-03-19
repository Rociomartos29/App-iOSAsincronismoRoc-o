//
//  TransformationsRepository.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 19/3/24.
//

import Foundation

// Real
final class TransformationsRepository: TransformationsRepositoryProtocol {
    func getTransformation(filter: UUID?) async -> [Transformacione] {
        await network.getTransformations(filter: filter!)
    }
    
    private var network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol = NetworkTransformations()) {
        self.network = network
    }
}

// Fake
final class TransformationsRepositoryFake: TransformationsRepositoryProtocol {
    func getTransformation(filter: UUID?) async -> [Transformacione] {
        await network.getTransformations(filter: filter!)
    }
    
    private var network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol = NetworkTransfotmationsFake()) {
        self.network = network
    }
}
