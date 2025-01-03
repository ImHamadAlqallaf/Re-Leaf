//
//  NotificationsTableViewController.swift
//  ReLeaf
//
//  Created by BP-36-224-15 on 28/12/2024.
//

import UIKit
import UserNotifications

class NotificationsTableViewController: UITableViewController, UNUserNotificationCenterDelegate {

    var notifications: [Notification] = []
    var currentNotificationIndex = 0  // To track which notification to show
    var isNotificationSent = false // To track if the notification was already sent
    
    @IBOutlet weak var notifbtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.rowHeight = 100
        showAlert()
        
        // Request notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission denied: \(error.localizedDescription)")
            }
        }
        
        // Set the delegate for notifications
        UNUserNotificationCenter.current().delegate = self
        
        // Load initial notifications (if any)
        loadNotifications()
    }

    func loadNotifications() {
        if let path = Bundle.main.path(forResource: "localData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedData = try JSONDecoder().decode(LocalData.self, from: data)
                notifications = decodedData.notifications
            } catch {
                print("Error loading JSON data: \(error)")
            }
        } else {
            print("JSON file not found")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNotificationIndex  // Return the number of rows up to the current notification index
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell
        let notification = notifications[indexPath.row]
        cell.notificationlbl.text = "\(notification.message)"
        return cell
    }

    // Action method for the bar button
    @IBAction func tabBarItemTapped(_ sender: UIBarButtonItem) {
        if currentNotificationIndex < notifications.count {
            // Load one new notification (show next one)
            currentNotificationIndex += 1
            tableView.reloadData()  // Reload to display the new notification cell
            
            // Send the notification with the message from the new cell
            let message = notifications[currentNotificationIndex - 1].message
            sendNotification(withMessage: message)
        } else {
            // Show an alert when there are no more notifications
            showNoMoreNotificationsAlert()
        }
    }
    
    // Create and schedule a notification with the given message
    func sendNotification(withMessage message: String) {
        let content = UNMutableNotificationContent()
        content.title = "New Notification from Releaf"
        content.body = message  // Set the body to the message
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.\(currentNotificationIndex)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully with message: \(message)")
            }
        }
    }

    // Show alert when entering the page
    func showAlert() {
        let alert = UIAlertController(title: "Notification", message: "You have new notifications.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // Show alert when there are no more notifications
    func showNoMoreNotificationsAlert() {
        let alert = UIAlertController(title: "No More Notifications", message: "You do not have any notifications.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // Handle notification while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

    // Handle user tapping the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
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


