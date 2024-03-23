//
//  TransformViewModel.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import Combine

final class TransformationsViewModel: ObservableObject {
    @Published var transform = [Transformacione]()
    var hero: HerosModel
    
    private var useCase: TransformationsUseCase
    
    init(useCase: TransformationsUseCaseProtocol = TransformationsUseCase(), hero:HerosModel) {
        self.useCase = useCase as! TransformationsUseCase
        self.hero = hero
        Task{
            await getTransform(id: hero.id)
        }
        
    }
    
    func getTransform(id: UUID) async {
        do {
            let data = try await useCase.getTransformations(forHeroWithID: id)
            DispatchQueue.main.async {
                self.transform = data
            }
        } catch {
            // Manejar el error aquí, por ejemplo, imprimirlo en la consola
            print("Error fetching transformations: \(error)")
        }
    }
}
