//
//  TransformViewModel.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import Combine

final class TransformationsViewModel: ObservableObject {
    @Published var transformations = [Transformacione]()
    
    private var useCase: TransformationsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: TransformationsUseCaseProtocol = TransformationsUseCase()) {
        self.useCase = useCase
    }
    
    func loadTransformations() {
        
        let data = await useCase.getTransformations(filter: "")
        
        DispatchQueue.main.async{
            self.herosData = data
        }
    }
}
