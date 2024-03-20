//
//  DetailViewController.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 19/3/24.
//

import UIKit
import Combine 

class DetailViewController: UIViewController {
    @IBOutlet weak var imageFondo: UIImageView!
    @IBOutlet weak var ImageHero: UIImageView!
    @IBOutlet weak var tranButton: UIButton!
    
    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var nameHero: UILabel!
    var heroID: String?
    private var viewModel: HeroDetailsViewModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        guard let heroID = heroID else {
            fatalError("No se proporcionó el ID del héroe.")
        }
        
        let heroDetailsService = HeroDetailsService() // Supongamos que este es tu servicio para obtener detalles del héroe
        viewModel = HeroDetailsViewModel(heroID: heroID, heroDetailsService: heroDetailsService)
        
        // Observamos las propiedades del ViewModel para actualizar la vista cuando cambian
        viewModel?.$heroName.sink { [weak self] name in
            self?.nameHero.text = name
        }.store(in: &cancellables)
        
        viewModel?.$heroPhoto.sink { [weak self] url in
            guard let urlString = url, let imageURL = URL(string: urlString) else {
                return
            }
            URLSession.shared.dataTaskPublisher(for: imageURL)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] image in
                    self?.ImageHero.image = image
                }.store(in: &self!.cancellables) 
        }.store(in: &cancellables)
        
        viewModel?.$heroDescription.sink { [weak self] description in
            self?.descripcion.text = description
        }.store(in: &cancellables)
    }
}
