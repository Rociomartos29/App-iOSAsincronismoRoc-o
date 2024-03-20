//
//  UIImage+Extensions.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//


import UIKit


extension UIImageView {
    func loadImageAsync(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
