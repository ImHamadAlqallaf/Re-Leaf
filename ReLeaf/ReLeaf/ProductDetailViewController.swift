//
//  ProductDetailViewController.swift
//  prac
//
//  Created by Mac on 28/12/2024.
//

import UIKit

class ProductDetailViewController: UIViewController {

    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
        var productName: String?
       var productPrice: Double?
       var productImage: String?
    
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Update UI with the received data
            if let name = productName, let price = productPrice, let imageName = productImage {
                productNameLabel.text = name
                productPriceLabel.text = "BHD \(price)"
                productImageView.image = UIImage(named: imageName)
            } else {
                print("No Product Data Received!")
            }
        print("Received Product Data:")
        print("Name: \(productName ?? "No Name")")
        print("Price: \(productPrice ?? 0.0)")
        print("Image: \(productImage ?? "No Image")")

        }
}
