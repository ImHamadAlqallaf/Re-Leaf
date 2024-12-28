//
//  SpecialViewController.swift
//  prac
//
//  Created by Mac on 28/12/2024.
//

import UIKit

class SpecialViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productNames = [String]()
    var productPrices = [Double]()
    var productImages = [String]()

    
    override func viewDidLoad() {
        if let path = Bundle.main.path(forResource: "localData 2", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    if let shops = json?["shops"] as? [[String: Any]] {
                        for shop in shops {
                            if let products = shop["products"] as? [[String: Any]] {
                                for product in products {
                                    
                                    productNames.append(product["name"] as? String ?? "Unknown")
                                    productPrices.append(product["price"] as? Double ?? 0.0)
                                    productImages.append(product["image"] as? String ?? "")
                                }
                            }
                        }
                    }
                } catch {
                    print("Error loading JSON: \(error.localizedDescription)")
                }
            }
        tableView.delegate = self
        tableView.dataSource = self
           
            tableView.reloadData()
    }



        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return productNames.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecialTableViewCell

                
                cell.productNameLabel.text = productNames[indexPath.row]
                cell.productPriceLabel.text = "BHD \(productPrices[indexPath.row])"
                cell.productImageView.image = UIImage(named: productImages[indexPath.row])

                return cell
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetail" {
            if let detailVC = segue.destination as? ProductDetailViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                
                detailVC.productName = productNames[indexPath.row]
                detailVC.productPrice = productPrices[indexPath.row]
                detailVC.productImage = productImages[indexPath.row]
            } else {
                print("Segue destination is not ProductDetailViewController or indexPath is missing!")
            }
        }
    }

    }
