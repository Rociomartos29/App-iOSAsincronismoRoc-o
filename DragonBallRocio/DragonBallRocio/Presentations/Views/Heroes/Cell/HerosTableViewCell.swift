//
//  HerosTableViewCell.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import UIKit

class HerosTableViewCell: UITableViewCell {
    @IBOutlet weak var imagHero: UIImageView!
    
    @IBOutlet weak var nameHero: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
