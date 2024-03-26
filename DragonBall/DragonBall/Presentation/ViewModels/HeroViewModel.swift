//
//  HeroViewModel.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import Combine

protocol TransformationsLoader {
    func loadTransformations(for hero: HerosModel) async throws -> [Transformation]
}

final class HerosViewModel: ObservableObject{
    @Published var herosData = [HerosModel]()
    @Published var transformation = [Transformation]()
    private var useCaseHeros: HerosUseCaseProtocol
    private var useCaseTransformations: TransformationsUseCaseProtocol

       init(useCaseHeros: HerosUseCaseProtocol, useCaseTransformations: TransformationsUseCaseProtocol) {
           self.useCaseHeros = useCaseHeros
           self.useCaseTransformations = useCaseTransformations
           Task(priority: .high){
               await getHeros()
           }
       }
    func loadTransformations(for hero: HerosModel) async throws -> [Transformation] {
        return try await useCaseTransformations.getTransformations(forHeroWithID: hero.id)
       }

    func getHeros() async{
        let data = await useCaseHeros.getHeros(filter: "")
        
        DispatchQueue.main.async{
            self.herosData = data
        }
    }
}
