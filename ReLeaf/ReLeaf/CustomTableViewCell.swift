//
//  StoreInfoTableViewCell.swift
//  ReLeaf
//
//  Created by BP-36-201-17 on 25/12/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var StoreNamelbl: UILabel!
    @IBOutlet weak var StoreLogoimg: UIImageView!
    @IBOutlet weak var AddProductbtn: UIButton!
   //2nd row
    @IBOutlet weak var StoreInfolbl: UILabel!
    //3rd
    @IBOutlet weak var StoreProductslbl: UILabel!
    //product row
    @IBOutlet weak var ProductPictureimg: UIImageView?
    @IBOutlet weak var ProductNamelbl: UILabel?
    @IBOutlet weak var ProductPricelbl: UILabel?
    @IBOutlet weak var ProductQTYlbl: UILabel?
    @IBOutlet weak var UpdateProductbtn: UIButton!
    @IBOutlet weak var DeleteProductbtn: UIButton!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        print("CustomTableViewCell awakeFromNib called")
        print("Store Name Label: \(String(describing: StoreNamelbl))")
    }

  

        // Configure the view for the selected state
    }


