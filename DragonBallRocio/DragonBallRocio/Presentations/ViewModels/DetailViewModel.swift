//
//  DetailViewModel.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 20/3/24.
//

import Foundation
import UIKit

// ViewModel para los detalles del héroe
// ViewModel para los detalles del héroe
final class HeroDetailsViewModel: ObservableObject {
    @Published var heroName: String = ""
    @Published var heroPhoto: String?
    @Published var heroDescription: String = ""
    
    private let heroID: String
    private let heroDetailsService: HeroDetailsServiceProtocol // Interfaz del servicio
    
    init(heroID: String, heroDetailsService: HeroDetailsServiceProtocol) {
        self.heroID = heroID
        self.heroDetailsService = heroDetailsService
    }
    
    func fetchHeroDetails() {
        heroDetailsService.getHeroDetails(heroID: heroID) { [weak self] result in
            switch result {
            case .success(let heroDetails):
                self?.updateHeroDetails(heroDetails)
            case .failure(let error):
                print("Error obteniendo detalles del héroe:", error)
                // Aquí puedes manejar el error, por ejemplo, actualizando una propiedad de error en el ViewModel
            }
        }
    }
    
    private func updateHeroDetails(_ details: Detalles) {
        // Asignar los detalles del héroe a las propiedades del ViewModel
        heroName = details.name
        heroPhoto = details.photo
        heroDescription = details.descripcion
    }
}
