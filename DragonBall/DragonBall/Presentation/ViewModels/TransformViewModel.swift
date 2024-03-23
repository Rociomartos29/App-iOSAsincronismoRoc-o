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
    
    private var useCase: TransformationsUseCaseProtocol
    
    init(useCases: TransformationsUseCaseProtocol = TransformationsUseCase(), hero:HerosModel) {
        self.useCase = useCases 
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
            // Manejar el error
            print("Error fetching transformations: \(error)")
        }
    }
}
