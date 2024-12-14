//
//  ProdCompViewController.swift
//  ReLeaf
//
//  Created by Student on 14/12/2024.
//

import UIKit

class ProdCompViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    let productImages = ["hand_soap", "hand", "Feedback"] // Add your image names here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UICollectionView Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return productImages.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
            if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
                imageView.image = UIImage(named: productImages[indexPath.row])
            }
            return cell
        }
    
    // MARK: - UICollectionView Delegate (Optional: For handling item selection)

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Selected image at index: \(indexPath.row)")
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
