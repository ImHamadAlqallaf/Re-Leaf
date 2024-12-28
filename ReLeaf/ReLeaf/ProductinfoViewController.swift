//
//  ProductinfoViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-09 on 25/12/2024.
//

import UIKit

class ProductinfoViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabelinfo: UILabel!
    @IBOutlet weak var productPriceLabelinfo: UILabel!
    @IBOutlet weak var productDescriptionLabelInfo: UILabel!
    @IBOutlet weak var QuantityLabelinfo: UILabel!
    
    
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    // Product Data Passed from HomeViewController
        var selectedProduct: Product?
        var productQuantity: Int = 1
        
        var cartItems: [(name: String, price: Double, quantity: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedProduct = selectedProduct else {
            print("❌ No product data passed!")
            return
        }
        print("🛠️ Loaded ProductInfoViewController with product: \(selectedProduct.name), ProductID: \(selectedProduct.id)")
        updateUI()
        }
    
    func updateUI(){
        guard let product = selectedProduct else {
                   print("❌ No product data passed!")
                   return
               }
        productNameLabelinfo.text = product.name
        productPriceLabelinfo.text = "BHD \(product.price)"
        productDescriptionLabelInfo.text = product.description
        QuantityLabelinfo.text = "\(productQuantity)"
        productImageView.image = UIImage(named: product.image) ?? UIImage(named: "placeholder")
                
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
        guard let product = selectedProduct else { return }
                
                if productQuantity > 0 {
                    let item = (name: product.name, price: product.price, quantity: productQuantity)
                    cartItems.append(item)
                    
                    let alert = UIAlertController(title: "Success", message: "\(product.name) added to cart!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    productQuantity = 1
                    updateUI()
                }
    }
    
    @IBAction func viewMoreInfoTapped(_ sender: UIButton) {
            guard let viewMoreInfoVC = storyboard?.instantiateViewController(withIdentifier: "ViewMoreInfoViewController") as? ViewMoreInfoViewController else {
                print("❌ Failed to instantiate ViewMoreInfoViewController.")
                return
            }
            
            // Check if the selected product exists
            if let selectedProduct = selectedProduct {
                print("✅ Passing Product: \(selectedProduct.name)")
                viewMoreInfoVC.product = selectedProduct
            } else {
                print("❌ selectedProduct is nil before passing.")
            }
            
            navigationController?.pushViewController(viewMoreInfoVC, animated: true)
        }

    @IBAction func viewReviewsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AReviews", bundle: nil)
           guard let reviewsVC = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController else {
               print("❌ Failed to instantiate ReviewsViewController.")
               return
           }
           
           // Pass the productID to ReviewsViewController
           if let productID = selectedProduct?.id {
               reviewsVC.productID = productID
               print("✅ Passing ProductID to ReviewsViewController: \(productID)")
           } else {
               print("❌ No productID available to pass.")
           }
        // Pass the product information to WriteReviewViewController
            reviewsVC.product = selectedProduct
           
           navigationController?.pushViewController(reviewsVC, animated: true)
       }

    
    @IBAction func viewAlternativesTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Alternatives", bundle: nil)
        guard let prodCompVC = storyboard.instantiateViewController(withIdentifier: "ProdCompViewController") as? ProdCompViewController else {
            print("❌ Failed to instantiate ProdCompViewController.")
            return
        }
        
        // Pass the selected product to ProdCompViewController
        prodCompVC.originalProduct = selectedProduct
        
        navigationController?.pushViewController(prodCompVC, animated: true)
    }
}

