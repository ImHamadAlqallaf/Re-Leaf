//
//  OrderedCartViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-18 on 27/12/2024.
//

import UIKit

class OrderedCartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAlertButtonClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to proceed?", preferredStyle: .alert)
        
       
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            print("User confirmed")
           
            self.goToNextPage()
        }
        
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("User cancelled")
     
        }
        
      
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
      
        present(alertController, animated: true, completion: nil)
    }
    
    //
    func goToNextPage() {
       
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "NextCartViewController") {
           
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
