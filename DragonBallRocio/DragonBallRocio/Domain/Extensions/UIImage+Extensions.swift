//
//  UIImage+Extensions.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//


import UIKit

extension UIImageView {
    func loadImageRemote(url: URL){
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let imagen = UIImage(data: data){
                    //todo OK.
                    DispatchQueue.main.async {
                        self?.image = imagen
                    }
                }
            }
        }
    }
    
}
