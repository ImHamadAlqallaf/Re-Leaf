//
//  ProfileViewController.swift
//  ReLeaf
//
//  Created by Hussain Nader on 26/12/2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets for the table view and header elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    // Profile items
    let profileItems = [
        "Account Settings",
        "Product Impact Tracker",
        "Impact Metric Dashboard",
        "Notification",
        "Log out"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure table view
        tableView.delegate = self
        tableView.dataSource = self

        // Configure profile header
        configureProfileHeader()
    }
    
    // Configure profile header with user data
    func configureProfileHeader() {
        profileImageView.image = UIImage(systemName: "person.circle") // Default image
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        
        // Retrieve user data from SessionManager
        if let user = SessionManager.shared.currentUser {
            nameLabel.text = user.userName
            phoneLabel.text = user.number // Use `number` for the phone number
        } else {
            nameLabel.text = "Full Name"
            phoneLabel.text = "33333333"
        }
    }
    
    // MARK: - TableView DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        cell.textLabel?.text = profileItems[indexPath.row]
        
        // Customize log out row
        if indexPath.row == 4 {
            cell.textLabel?.textColor = .red
            cell.accessoryType = .none
        } else {
            cell.textLabel?.textColor = .black
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "toAccountSettings", sender: self)
        case 1:
            self.performSegue(withIdentifier: "toProductImpactTracker", sender: self)
        case 2:
            self.performSegue(withIdentifier: "toImpactMetricDashboard", sender: self)
        case 3:
            self.performSegue(withIdentifier: "toNotification", sender: self)
        case 4:
            handleLogout()
        default:
            break
        }
    }
    
    // MARK: - Logout Logic
    
    func handleLogout() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.performLogout()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func performLogout() {
        print("Logged out successfully")
        // Clear the session
        SessionManager.shared.currentUser = nil
        
        // Load the LoginSignup.storyboard
        let storyboard = UIStoryboard(name: "LoginSignup", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = loginViewController
                window.makeKeyAndVisible()
            }
        }
    }
}
