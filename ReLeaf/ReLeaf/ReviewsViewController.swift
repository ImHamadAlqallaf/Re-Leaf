//
//  ReviewsViewController.swift
//  ReLeaf
//
//  Created by BP-needchange on 15/12/2024.
//

import UIKit
import FirebaseFirestore


class ReviewsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var averageStarsStackView: UIStackView!
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
        let db = Firestore.firestore()
            
            db.collection("reviews").getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error fetching reviews: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No reviews found.")
                    self?.reviews = []
                    self?.updateAverageRating() // Update UI with no reviews
                    self?.tableView.reloadData()
                    return
                }
                
                do {
                    self?.reviews = try documents.compactMap { document in
                        try? document.data(as: Review.self)
                    }
                    self?.updateAverageRating() // Update UI with the average rating
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch let decodeError {
                    print("Error decoding review data: \(decodeError.localizedDescription)")
                }
            }
    }
    
//    func listenForReviewUpdates() {
//        let db = Firestore.firestore()
//        db.collection("reviews").order(by: "timestamp", descending: true)
//            .addSnapshotListener { [weak self] snapshot, error in
//                if let error = error {
//                    print("Error listening for updates: \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let documents = snapshot?.documents else {
//                    print("No documents in snapshot")
//                        self?.reviews = []
//                        self?.updateAverageRating() // Update UI with no reviews
//                        self?.tableView.reloadData()
//                    return
//                }
//                
//                do {
//                    self?.reviews = try documents.map { document in
//                        return try document.data(as: Review.self)
//                    }
//                        self?.updateAverageRating()
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                } catch let decodeError {
//                    print("Error decoding documents: \(decodeError.localizedDescription)")
//                }
//            }
//    }

    
    func updateAverageRating() {
        guard !reviews.isEmpty else {
            averageRatingLabel.text = "0.0"
            updateStars(for: 0) // Show empty stars
            return
        }
        
        // Calculate average rating
        let totalRating = reviews.reduce(0) { $0 + ($1.rating ?? 0) }
        let averageRating = Double(totalRating) / Double(reviews.count)
        
        // Update the label
        averageRatingLabel.text = String(format: "%.1f", averageRating) // e.g., "4.5"
        
        // Update the stars
        updateStars(for: averageRating)
    }
    
    func updateStars(for rating: Double) {
        let starImageViews = averageStarsStackView.arrangedSubviews.compactMap { $0 as? UIImageView }
        for (index, imageView) in starImageViews.enumerated() {
            if Double(index + 1) <= rating {
                imageView.image = UIImage(systemName: "star.fill") // Filled star
            } else if Double(index) < rating {
                imageView.image = UIImage(systemName: "star.lefthalf.fill") // Half star
            } else {
                imageView.image = UIImage(systemName: "star") // Empty star
            }
        }
    }


        
        // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviews.isEmpty {
            tableView.setEmptyMessage("No reviews yet. Be the first to add a review!")
        } else {
            tableView.restore()
        }
        return reviews.count
    }

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewsTableViewCell else {
                fatalError("Unable to dequeue cell with identifier 'ReviewCell'")
            }
            let review = reviews[indexPath.row]
            cell.configure(with: review)
            return cell
        }
    }

        extension UITableView {
            func setEmptyMessage(_ message: String) {
                let messageLabel = UILabel()
                messageLabel.text = message
                messageLabel.textAlignment = .center
                messageLabel.textColor = .gray
                messageLabel.sizeToFit()
                self.backgroundView = messageLabel
                self.separatorStyle = .none
            }
            
            func restore() {
                self.backgroundView = nil
                self.separatorStyle = .singleLine
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


