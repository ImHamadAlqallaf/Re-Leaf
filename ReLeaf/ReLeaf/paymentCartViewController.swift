//
//  paymentCartViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-18 on 27/12/2024.
//

import UIKit

class paymentCartViewController: UIViewController {
    
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    @IBOutlet weak var onlinePaymentButton: UIButton!
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    var isOnlinePaymentSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()

        checkoutButton.isEnabled = false
        setTextFieldsEnabled(false)
        
        // Add target to check when the text fields change (for online payment)
        [cardNameTextField, cardNumberTextField, expiryDateTextField, cvvTextField].forEach {
            $0?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBAction func onlinePaymentButtonTapped(_ sender: UIButton) {
        isOnlinePaymentSelected = true
        setTextFieldsEnabled(true) // Enable the text fields for online payment
        checkIfFieldsAreFilled() // Enable checkout button only if all fields are filled
    }
    
    @IBAction func cashOnDeliveryButtonTapped(_ sender: UIButton) {
        isOnlinePaymentSelected = false
        setTextFieldsEnabled(false) // Disable card input fields
        checkoutButton.isEnabled = true // Directly enable the checkout button
    }
    
    @IBAction func checkoutButtonTapped(_ sender: UIButton) {
        if isOnlinePaymentSelected {
            // Online Payment selected: Validate card fields
            guard !cardNameTextField.text!.isEmpty,
                  !cardNumberTextField.text!.isEmpty,
                  !expiryDateTextField.text!.isEmpty,
                  !cvvTextField.text!.isEmpty else {
                // If any card field is empty, show an alert
                showAlert(message: "Please fill in all card details.")
                return
            }
            // Proceed with online payment
            print("Proceeding to checkout with Online Payment...")
            proceedToNextPage() // Call function to navigate to the next page
        } else {
            // Cash-On Delivery selected: Proceed directly to the next page
            print("Proceeding to checkout with Cash-On Delivery...")
            proceedToNextPage() // Call function to navigate to the next page
        }
    }
    
    // Enable/Disable card text fields
    func setTextFieldsEnabled(_ isEnabled: Bool) {
        cardNameTextField.isEnabled = isEnabled
        cardNumberTextField.isEnabled = isEnabled
        expiryDateTextField.isEnabled = isEnabled
        cvvTextField.isEnabled = isEnabled
    }
    
    // Check if all card fields are filled
    @objc func checkIfFieldsAreFilled() {
        let allFilled = !cardNameTextField.text!.isEmpty &&
                        !cardNumberTextField.text!.isEmpty &&
                        !expiryDateTextField.text!.isEmpty &&
                        !cvvTextField.text!.isEmpty
        checkoutButton.isEnabled = allFilled
    }
    
    // Called when text field changes to check if all fields are filled
    @objc func textFieldDidChange() {
        checkIfFieldsAreFilled()
    }
    
    // Helper function to show alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Incomplete Form", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Function to proceed to the next page
    func proceedToNextPage() {
        // Add your navigation logic here, e.g., performSegue or pushViewController
        print("Navigating to the next page...")
        // Example: performSegue(withIdentifier: "checkoutSegue", sender: self)
    }
}
