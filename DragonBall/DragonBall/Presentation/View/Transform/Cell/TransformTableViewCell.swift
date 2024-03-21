//
//  TransformTableViewCell.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import UIKit

class TransformTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTransform: UILabel!
    @IBOutlet weak var imageTransform: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
