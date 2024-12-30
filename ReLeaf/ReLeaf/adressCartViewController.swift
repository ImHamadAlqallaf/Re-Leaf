//
//  adressCartViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-18 on 27/12/2024.
//

import UIKit

class adressCartViewController: UIViewController {

        @IBOutlet weak var streetAddressTextField: UITextField!
        @IBOutlet weak var blockNumberTextField: UITextField!
        @IBOutlet weak var aptNumberTextField: UITextField!
        
        @IBOutlet weak var proceedButton: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
           
            proceedButton.isEnabled = false
          
            [streetAddressTextField, blockNumberTextField, aptNumberTextField].forEach {
                $0?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            }
        }
        
        @objc func textFieldDidChange() {
            let isFormFilled = !streetAddressTextField.text!.isEmpty && !blockNumberTextField.text!.isEmpty && !aptNumberTextField.text!.isEmpty
            proceedButton.isEnabled = isFormFilled
        }
        
        @IBAction func proceedButtonTapped(_ sender: UIButton) {
            
            guard !streetAddressTextField.text!.isEmpty, !blockNumberTextField.text!.isEmpty, !aptNumberTextField.text!.isEmpty else {
               
                showAlert(message: "Please fill in all fields.")
                return
            }
            
            
            print("Proceeding to the next screen...")
        }
        
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Incomplete Form", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
