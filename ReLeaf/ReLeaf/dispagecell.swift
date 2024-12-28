import UIKit

class dispagecell: UITableViewCell {
    
    @IBOutlet weak var discountcardlabel: UILabel!
    @IBOutlet weak var percentlabel: UILabel!
    @IBOutlet weak var discountcodelabel: UILabel!
    
    @IBAction func Apply(_ sender: Any) {
        // Create an alert
        let alert = UIAlertController(title: "Success", message: "Discount has been applied!", preferredStyle: .alert)
        
        // Add an OK action to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert
        if let viewController = self.parentViewController() {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

// Helper extension to find the parent view controller of a cell
extension UIView {
    func parentViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
