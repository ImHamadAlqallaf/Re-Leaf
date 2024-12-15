//
//  ReviewsViewController.swift
//  ReLeaf
//
//  Created by BP-needchange on 15/12/2024.
//

import UIKit
import FirebaseFirestore


class ReviewsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var reviews: [Review] = []
        let db = Firestore.firestore()

        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            fetchReviews()
        }
    
    func fetchReviews() {
            db.collection("reviews").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error.localizedDescription)")
                } else {
                    self.reviews = snapshot?.documents.compactMap { document in
                        try? document.data(as: Review.self)
                    } ?? []
                    self.tableView.reloadData()
                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return reviews.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
        let review = reviews[indexPath.row]
        cell.configure(with: review)
        return cell
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


