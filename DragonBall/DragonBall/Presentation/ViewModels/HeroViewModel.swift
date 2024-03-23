//
//  HeroViewModel.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import Combine

final class HerosViewModel: ObservableObject{
    @Published var herosData = [HerosModel]()
    
    private var useCaseHeros: HerosUseCaseProtocol
    
    init(useCaseHeros: HerosUseCaseProtocol = HerosUseCase()) {
        self.useCaseHeros = useCaseHeros
        Task(priority: .high){
            await getHeros()
        }
    }
    func getHeros() async{
        let data = await useCaseHeros.getHeros(filter: "")
        
        DispatchQueue.main.async{
            self.herosData = data
        }
    }
}
