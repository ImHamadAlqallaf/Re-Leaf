//
//  SpecialTableViewCell.swift
//  prac
//
//  Created by Mac on 28/12/2024.
//

import UIKit


class SpecialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    @IBOutlet weak var productPriceLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
