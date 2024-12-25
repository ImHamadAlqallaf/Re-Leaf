//
//  ProductinfoViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-09 on 25/12/2024.
//

import UIKit

class ProductinfoViewController: UIViewController {
    
    @IBOutlet weak var productNameLabelinfo: UILabel!
    @IBOutlet weak var productPriceLabelinfo: UILabel!
    @IBOutlet weak var QuantityLabelinfo: UILabel!
    
    
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    var productName: String = "Product name"
    var productPrice: Double = 3.00
    var productQuantity: Int = 1
    
    
    
    var cartItems: [(name: String, price: Double, quantity: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        }
    
    func updateUI(){
        productNameLabelinfo.text = productName
        QuantityLabelinfo.text = "\(productQuantity)"
        
        let totalPrice = productPrice * Double(productQuantity)
        
        productPriceLabelinfo.text = "BHD \(totalPrice)"
        QuantityLabelinfo.text = "\(productQuantity)"
        
        decreaseButton.isEnabled = productQuantity > 1
        increaseButton.isEnabled = productQuantity < 100
    }
    
    @IBAction func incrementQuantity(_ sender: Any) {
        productQuantity += 1
        updateUI()
    }
    
    @IBAction func decrementQuantity(_ sender: Any) {
        if productQuantity > 0 {
            productQuantity -= 1
            updateUI()
        }
    }
    
    
    @IBAction func addToCart(_ sender: UIButton) {
        if productQuantity > 0 {
            let item = (name: productName, price: productPrice, quantity: productQuantity)
            cartItems.append(item)
            
            let alert = UIAlertController(title: "Success", message: "\(productName) added to cart!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            productQuantity = 1
            updateUI()
        }
    }
}

