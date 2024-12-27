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
        // Create the alert controller
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to proceed?", preferredStyle: .alert)
        
        // Create the Confirm action
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            print("User confirmed")
            // Navigate to the next page programmatically
            self.goToNextPage()
        }
        
        // Create the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("User cancelled")
            // Do nothing, stay on the same page
        }
        
        // Add actions to the alert controller
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    // Function to navigate to the next page
    func goToNextPage() {
        // Instantiate the next view controller
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "NextViewController") {
            // Navigate to the next view controller
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
