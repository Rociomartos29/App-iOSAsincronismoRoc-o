//
//  TransformationViewController.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 19/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageFondo: UIImageView!
    @IBOutlet weak var ImageHero: UIImageView!
    @IBOutlet weak var tranButton: UIButton!

    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var nameHero: UILabel!
    var hero: HerosModel?
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configuramos la vista con los detalles del héroe
            if let hero = hero {
                nameHero.text = hero.name
                descripcion.text = hero.description
                ImageHero.image = UIImage(named: hero.photo)
            }
        }
    }
