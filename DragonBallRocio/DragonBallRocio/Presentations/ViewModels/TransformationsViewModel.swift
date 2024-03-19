//
//  TransformationsViewModel.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 19/3/24.
//

import Foundation
import Combine

final class TransformationsViewModel: ObservableObject{
    @Published var transformations = [Transformacione]()
        
        private var useCase: TransformationsUseCaseProtocol
        private var cancellables = Set<AnyCancellable>()
        
    init(useCase: TransformationsUseCaseProtocol = TransformationsUseCase()) {
            self.useCase = useCase
           
        }
        
    func getTransformations() async {
        await useCase.getTransformations(filter: nil)
                
        }
    }
