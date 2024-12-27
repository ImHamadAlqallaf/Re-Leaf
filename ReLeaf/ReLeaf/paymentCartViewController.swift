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
        
       
        [cardNameTextField, cardNumberTextField, expiryDateTextField, cvvTextField].forEach {
            $0?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBAction func onlinePaymentButtonTapped(_ sender: UIButton) {
        isOnlinePaymentSelected = true
        setTextFieldsEnabled(true)
        checkIfFieldsAreFilled()
    }
    
    @IBAction func cashOnDeliveryButtonTapped(_ sender: UIButton) {
        isOnlinePaymentSelected = false
        setTextFieldsEnabled(false)
        checkoutButton.isEnabled = true     }
    
    @IBAction func checkoutButtonTapped(_ sender: UIButton) {
        if isOnlinePaymentSelected {
       
            guard !cardNameTextField.text!.isEmpty,
                  !cardNumberTextField.text!.isEmpty,
                  !expiryDateTextField.text!.isEmpty,
                  !cvvTextField.text!.isEmpty else {
               
                showAlert(message: "Please fill in all card details.")
                return
            }
            
            print("Proceeding to checkout with Online Payment...")
            proceedToNextPage()
        } else {
          
            print("Proceeding to checkout with Cash-On Delivery...")
            proceedToNextPage()
        }
    }
    
    
    func setTextFieldsEnabled(_ isEnabled: Bool) {
        cardNameTextField.isEnabled = isEnabled
        cardNumberTextField.isEnabled = isEnabled
        expiryDateTextField.isEnabled = isEnabled
        cvvTextField.isEnabled = isEnabled
    }
    
   
    @objc func checkIfFieldsAreFilled() {
        let allFilled = !cardNameTextField.text!.isEmpty &&
                        !cardNumberTextField.text!.isEmpty &&
                        !expiryDateTextField.text!.isEmpty &&
                        !cvvTextField.text!.isEmpty
        checkoutButton.isEnabled = allFilled
    }
    
    
    @objc func textFieldDidChange() {
        checkIfFieldsAreFilled()
    }
    
   
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Incomplete Form", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func proceedToNextPage() {
        
        print("Navigating to the next page...")
       
    }
}
