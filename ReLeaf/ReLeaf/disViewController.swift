import UIKit

class disViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var distableview: UITableView!
    
    let discounts = [
            ("Discount Card 1", "20%", "SFS2"),
            ("Discount Card 2", "30%", "RET4"),
            ("Discount Card 3", "50%", "AEG4")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distableview.delegate = self
        distableview.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dispagecell
                
                // Configure the cell with data
                let discount = discounts[indexPath.row]
                cell.discountcardlabel.text = discount.0
                cell.percentlabel.text = discount.1
                cell.discountcodelabel.text = discount.2
                
                return cell
    }

}
