//
//  HerosUseCase.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import Foundation

protocol HerosUseCaseProtocol{
    var repo: HerosRepositoryProtocol {get set}
    func getHeros(filter: String) async -> [HerosModel]
}

// Caso Real
final class HerosUseCase: HerosUseCaseProtocol{
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(Network: NetworkHeros())){
        self.repo = repo
    }

    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
}

//Fake
final class HeroUseCaseFake: HerosUseCaseProtocol{
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(Network: NetworkHeros())){
        self.repo = repo
    }

    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
}


