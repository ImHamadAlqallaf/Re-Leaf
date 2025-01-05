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
    @IBOutlet weak var StoreInfolbl: UILabel!
    @IBOutlet weak var StoreProductslbl: UILabel!
    @IBOutlet weak var ProductPictureimg: UIImageView?
    @IBOutlet weak var ProductNamelbl: UILabel?
    @IBOutlet weak var ProductPricelbl: UILabel?
    @IBOutlet weak var ProductQTYlbl: UILabel?
    @IBOutlet weak var UpdateProductbtn: UIButton!
    @IBOutlet weak var DeleteProductbtn: UIButton!

    var deleteAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        print("CustomTableViewCell awakeFromNib called")
        print("Store Name Label: \(String(describing: StoreNamelbl))")
        print("Delete Product Button: \(String(describing: DeleteProductbtn))") // Debug print
        
        // Add target action for delete button
        if let deleteButton = DeleteProductbtn {
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        } else {
            print("DeleteProductbtn is nil")
        }
    }

    @objc func deleteButtonTapped() {
        deleteAction?()
    }
}


