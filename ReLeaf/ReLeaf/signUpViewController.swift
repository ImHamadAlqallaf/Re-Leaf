//
//  signUpViewController.swift
//  ReLeaf
//
//  Created by Hussain Nader on 24/12/2024.
//

import UIKit

class signUpViewController: UIViewController {

    @IBOutlet weak var signUpNameTxt: UITextField!
    @IBOutlet weak var signUpNumberTxt: UITextField!
    @IBOutlet weak var signUpEmailTxt: UITextField!
    @IBOutlet weak var signUpPasswordTxt: UITextField!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Additional setup
       }
       
       @IBAction func signUpButtonTapped(_ sender: UIButton) {
           // Collect input
              let name = signUpNameTxt.text ?? ""
              let number = signUpNumberTxt.text ?? ""
              let email = signUpEmailTxt.text ?? ""
              let password = signUpPasswordTxt.text ?? ""
              
              // Validate input
              if name.isEmpty || number.isEmpty || email.isEmpty || password.isEmpty {
                  showAlert(title: "Input Error", message: "All fields are required.")
                  return
              }
              
              if !isValidNumber(number) {
                  showAlert(title: "Invalid Number", message: "The number must be exactly 8 digits.")
                  return
              }
              
              if !isValidEmail(email) {
                  showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
                  return
              }
              
              // Load existing users
              guard var localData = LocalDataManager.shared.loadLocalData() else {
                  showAlert(title: "Error", message: "Could not load user data.")
                  return
              }
              
              // Check if email already exists
              if localData.users.contains(where: { $0.email == email }) {
                  showAlert(title: "Sign Up Failed", message: "This email is already registered.")
                  return
              }
              
              // Create a new user
              let newUser = User(
                  id: UUID().uuidString,
                  userName: name,
                  number: number, // Pass the number as String
                  email: email,
                  password: password,
                  role: "customer" // Default role
              )
              
              // Add the new user to the data
              localData.users.append(newUser)
              
              // Save the updated data back to JSON
              saveUpdatedData(localData)
           
            // Set the current user in UserManager
            UserManager.shared.currentUser = newUser
              
              print("Welcome, \(newUser.userName)! Role: \(newUser.role), id: \(newUser.id)")
              
           // Perform segue to the home page
                   self.performSegue(withIdentifier: "signUpGoToHomePage", sender: self)
//              /// Navigate to the Tab Bar Controller
//           navigateToTabBarController()
       }
    
    
    func navigateToTabBarController() {
            // Load the Tab Bar Controller from the TabBar storyboard
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                // Set the Tab Bar Controller as the root view controller
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                }
            }
        }
    
    func isValidNumber(_ number: String) -> Bool {
        // Validate the number to ensure it's exactly 8 numeric digits
        let numberRegex = "^[0-9]{8}$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberPredicate.evaluate(with: number)
    }
       
       func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
           return emailPredicate.evaluate(with: email)
       }
       
       func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
               completion?()
           }))
           present(alert, animated: true)
       }
       
       func saveUpdatedData(_ data: LocalData) {
           let fileManager = FileManager.default
                   let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                   let destinationURL = documentsURL.appendingPathComponent("localData.json")
                   let encoder = JSONEncoder()
                   encoder.dateEncodingStrategy = .iso8601 // Ensure ISO8601 date format

                   do {
                       // Convert LocalData object to JSON
                       let jsonData = try encoder.encode(data)
                       
                       // Debug: Print the JSON data being saved
                       if let jsonString = String(data: jsonData, encoding: .utf8) {
                           print("JSON being saved: \(jsonString)")
                       }
                       
                       // Write the JSON data to the file
                       try jsonData.write(to: destinationURL, options: .atomic)
                       print("User data successfully saved to Documents directory.")
                   } catch {
                       print("Error writing JSON file: \(error)")
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


