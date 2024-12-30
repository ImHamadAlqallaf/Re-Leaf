//
//  ViewMoreInfoViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-09 on 26/12/2024.
//

import UIKit

class ViewMoreInfoViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productTitleLabel: UILabel!
    
    // Environmental Impact Labels
    @IBOutlet weak var co2EmissionLabel: UILabel!
    @IBOutlet weak var waterConservedLabel: UILabel!
    @IBOutlet weak var wasteReducedLabel: UILabel!
    
    
    @IBOutlet weak var materialsTextView: UILabel!
    
    @IBOutlet weak var certificateImageView: UIImageView!
    
    // MARK: - Properties
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("✅ ViewMoreInfoViewController loaded")
            print("🛠️ Product Passed: \(product?.name ?? "No Product")")
            print("🛠️ Product Debug Info: \(product.debugDescription)")

        
        // Do any additional setup after loading the view.
    }
    
    

    
        // MARK: - Setup UI
        private func setupUI() {
            guard let product = product else {
                print("❌ Product data is missing in setupUI!")
                return
            }

            print("🛠️ Updating UI with Product Data")
            print("📝 Product Name: \(product.name)")
            print("💵 Product Price: \(product.price)")
            print("🌍 CO₂ Emission: \(product.co2Emission)")
            print("💧 Water Conserved: \(product.waterUsage)")
            print("🗑️ Waste Reduced: \(product.plasticUsage)")
            print("🛡️ Certificate Image: \(product.badge)")

            // Update Labels
            productTitleLabel.text = product.name
            co2EmissionLabel.text = "\(product.co2Emission) Kg"
            waterConservedLabel.text = "\(product.waterUsage) L"
            wasteReducedLabel.text = "\(product.plasticUsage) g"
            materialsTextView.text = product.materials
            
            if let image = UIImage(named: product.badge) {
                certificateImageView.image = image
            } else {
                certificateImageView.image = UIImage(named: "placeholder")
            }
            
            certificateImageView.contentMode = .scaleAspectFit
        }


        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    
}
