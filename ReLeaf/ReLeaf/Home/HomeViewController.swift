//
//  HomeViewController.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import UIKit

class HomeViewController: UIViewController {
    //outlets
    
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    @IBOutlet weak var forYouCollectionView: UICollectionView!
    @IBOutlet weak var previousPurchasesCollectionView: UICollectionView!
    
    // Data Models
        var recommendedItems: [Product] = []
        var forYouItems: [Product] = []
        var previousPurchasesItems: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        setupCollectionViews()
        loadLocalData()
        
//        navigationController?.pushViewController(someViewController, animated: true)

        
        // Do any additional setup after loading the view.

        
        recommendedCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        forYouCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        previousPurchasesCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")

        
        
    }
    
    private func setupCollectionViews() {
            recommendedCollectionView.delegate = self
            recommendedCollectionView.dataSource = self
            
            forYouCollectionView.delegate = self
            forYouCollectionView.dataSource = self
            
            previousPurchasesCollectionView.delegate = self
            previousPurchasesCollectionView.dataSource = self
        }
    
    private func loadLocalData() {
        if let path = Bundle.main.path(forResource: "localData", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let decodedData = try JSONDecoder().decode(ProductLocalData.self, from: jsonData)
                recommendedItems = decodedData.shops.first?.products ?? []
                forYouItems = decodedData.shops.last?.products ?? []
                previousPurchasesItems = decodedData.shops.flatMap { $0.products }
                
                [recommendedCollectionView, forYouCollectionView, previousPurchasesCollectionView].forEach {
                    $0?.reloadData()
                }
            } catch {
                print("❌ Error decoding product JSON: \(error)")
            }
        }
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recommendedCollectionView:
            return recommendedItems.count
        case forYouCollectionView:
            return forYouItems.count
        case previousPurchasesCollectionView:
            return previousPurchasesItems.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        let product: Product
        switch collectionView {
        case recommendedCollectionView:
            product = recommendedItems[indexPath.item]
        case forYouCollectionView:
            product = forYouItems[indexPath.item]
        case previousPurchasesCollectionView:
            product = previousPurchasesItems[indexPath.item]
        default:
            return UICollectionViewCell()
        }
        
        cell.configure(with: product)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Product Info", bundle: nil)
        guard let productInfoVC = storyboard.instantiateViewController(withIdentifier: "ProductinfoViewController") as? ProductinfoViewController else {
            print("❌ Failed to instantiate ProductInfoViewController. Check Storyboard ID.")
            return
        }
        
        let selectedProduct: Product
        
        switch collectionView {
        case recommendedCollectionView:
            selectedProduct = recommendedItems[indexPath.item]
        case forYouCollectionView:
            selectedProduct = forYouItems[indexPath.item]
        case previousPurchasesCollectionView:
            selectedProduct = previousPurchasesItems[indexPath.item]
        default:
            return
        }
        
        // Pass the product data
        productInfoVC.selectedProduct = selectedProduct
        
        print("🛠️ Passing product to ProductInfoViewController: \(selectedProduct.name)")
        navigationController?.pushViewController(productInfoVC, animated: true)
    }



}
