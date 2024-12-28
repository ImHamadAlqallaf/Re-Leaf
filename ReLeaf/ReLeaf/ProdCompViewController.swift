//
//  ProdCompViewController.swift
//  ReLeaf
//
//  Created by Student on 14/12/2024.
//

import UIKit

class ProdCompViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var originalCo2EmissionLabel: UILabel!
    @IBOutlet weak var alternativePriceLabel: UILabel!
    @IBOutlet weak var alternativeCo2EmissionLabel: UILabel!
    @IBOutlet weak var alternativeCollectionView: UICollectionView!
    
    var originalProduct: Product?
        var alternativeProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alternativeCollectionView.dataSource = self
        alternativeCollectionView.delegate = self

        // Do any additional setup after loading the view.
        // Load alternative products
        loadAlternativeProducts()
        
        // Display original product information
        if let product = originalProduct {
            productImageView.image = UIImage(named: product.image)
            originalPriceLabel.text = "\(product.price)"
            originalCo2EmissionLabel.text = "\(product.co2EmissionSaved)"
        }

    }
    
    private func loadAlternativeProducts() {
            guard let category = originalProduct?.category else { return }
            let allProducts = LocalDataManager.shared.loadLocalData()?.shops.flatMap { $0.products } ?? []
            alternativeProducts = allProducts.filter { $0.category == category && $0.id != originalProduct?.id }
            alternativeCollectionView.reloadData()
        }
    
    // MARK: - UICollectionView Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return alternativeProducts.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "products", for: indexPath)
                if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
                    imageView.image = UIImage(named: alternativeProducts[indexPath.row].image)
                }
            return cell
        }
    
    // MARK: - UICollectionView Delegate (Optional: For handling item selection)

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedAlternative = alternativeProducts[indexPath.row]
            updateComparison(with: selectedAlternative)
        }
        
        private func updateComparison(with alternative: Product) {
            alternativePriceLabel.text = "BHD \(alternative.price)"
            alternativeCo2EmissionLabel.text = "\(alternative.co2EmissionSaved) kg CO2"
            
//            if let originalCo2 = originalProduct?.co2EmissionSaved {
//                let co2Difference = originalCo2 - alternative.co2EmissionSaved
//                co2DifferenceLabel.text = "\(co2Difference) kg CO2"
//            }
        }
        
    @IBAction func goToProductTapped(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Product Info", bundle: nil)
    guard let productInfoVC = storyboard.instantiateViewController(withIdentifier: "ProductinfoViewController") as? ProductinfoViewController else {
        print("❌ Failed to instantiate ProductinfoViewController.")
        return
    }
    
    // Pass the selected alternative product to ProductinfoViewController
    if let selectedAlternative = alternativeProducts.first(where: { $0.image == productImageView.image?.accessibilityIdentifier }) {
        productInfoVC.selectedProduct = selectedAlternative
    }
    
    navigationController?.pushViewController(productInfoVC, animated: true)
}
        
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     */
        // Get the new view controller using segue.destination.
    
