//
//  LoginViewController.swift
//  ReLeaf
//
//  Created by Hussain Nader on 21/12/2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmailTxt: UITextField!
    @IBOutlet weak var loginPasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print(path)
        }
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Get email and password from text fields
        let email = loginEmailTxt.text ?? ""
        let password = loginPasswordTxt.text ?? ""
        
        // Load and parse JSON data
        if let users = LocalDataManager.shared.loadLocalData()?.users {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            // Authenticate user
            if let user = users.first(where: { $0.email == email && $0.password == password }) {
                // Successful login
                print("Welcome, \(user.userName)! Role: \(user.role)")
                // Navigate to the next screen or display a success message
                //                      navigateToHomePage(for: user)
                // Navigate to the Tab Bar Controller
                if let user = users.first(where: { $0.email == email && $0.password == password }) {
                    // Successful login
                    UserManager.shared.currentUser = user
                    navigateToTabBarController()
                } else {
                    // Login failed
                    showAlert(title: "Login Failed", message: "Invalid email or password.")
                }
            } else {
                showAlert(title: "Error", message: "Could not load user data.")
            }
        }
        
        
        //    // Navigate to Home Page or Dashboard (example function, replace with your actual implementation)
        //    func navigateToHomePage(for user: User) {
        //        // Example: Navigate to a new screen (you'll need to create and connect a storyboard segue)
        //        performSegue(withIdentifier: "toHomePage", sender: user)
        //    }
        
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
        
        // Display alert for errors or invalid input
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
