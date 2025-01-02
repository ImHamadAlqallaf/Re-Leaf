//
//  NotificationsTableViewController.swift
//  ReLeaf
//
//  Created by BP-36-224-15 on 28/12/2024.
//

import UIKit
import UserNotifications // Import UserNotifications framework

class NotificationsTableViewController: UITableViewController {

    var notifications: [Notification] = []

    @IBOutlet weak var notifbtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.rowHeight = 100 // Set default row height
        
        // Request notification authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission denied: \(error.localizedDescription)")
            }
        }
        
        // Show alert when entering the page
        showAlert()
    }

    func loadNotifications() {
        if let path = Bundle.main.path(forResource: "localData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                print("JSON Data: \(String(data: data, encoding: .utf8) ?? "No data")") // Debugging
                let decodedData = try JSONDecoder().decode(LocalData.self, from: data)
                notifications = decodedData.notifications
                print("Notifications loaded: \(notifications)") // Debugging
                tableView.reloadData()
            } catch {
                print("Error loading JSON data: \(error)")
            }
        } else {
            print("JSON file not found")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows: \(notifications.count)") // Debugging
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell
        let notification = notifications[indexPath.row]
        cell.notificationlbl.text = "\(notification.message)"
        print("Configuring cell for row \(indexPath.row): \(notification.message)") // Debugging
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Implement the heightForRowAt method
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Set the height for each row
    }
    
    // Action method for tab bar button
    @IBAction func tabBarItemTapped(_ sender: UIBarButtonItem) {
        loadNotifications()
        sendNotification() // Call sendNotification to schedule a notification
    }
    
    // Create and schedule a notification
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "New Notifications"
        content.body = "You have new notifications."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
                // Debugging: Print the notification details
                print("Notification content: \(content)")
                print("Notification trigger: \(trigger)")
            }
        }
    }
    
    // Show alert when entering the page
    func showAlert() {
        let alert = UIAlertController(title: "Notification", message: "You have new notifications.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


