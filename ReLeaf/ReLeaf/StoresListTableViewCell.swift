//
//  StoresListTableViewCell.swift
//  ReLeaf
//
//  Created by Guest User on 25/12/2024.
//

import UIKit

class StoresListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var btnStoreEdit: UIButton!
    @IBOutlet weak var btnStoreDelete: UIButton!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
