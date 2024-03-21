//
//  HeroRepository.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation

// Caso Real

final class HerosRepository: HerosRepositoryProtocol{
    private var Network: NetworkHeros
    init(Network: NetworkHeros) {
        self.Network = Network
    }
    func getHeros(filter: String) async -> [HerosModel] {
        await Network.getHeros(filter: filter)
    }
}

//Caso Fake

final class HerosRepositoryFake: HerosRepositoryProtocol{

    private var netWork: NetworkHerosProtocol
    
    init(netWork: NetworkHerosProtocol = NetworkHerosFake()) {
        self.netWork = netWork
    }
    func getHeros(filter: String) async -> [HerosModel] {
        await netWork.getHeros(filter: filter)
    }
    
}
