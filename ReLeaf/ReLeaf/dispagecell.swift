import UIKit

class dispagecell: UITableViewCell {
    
    @IBOutlet weak var discountcardlabel: UILabel!
    @IBOutlet weak var percentlabel: UILabel!
    @IBOutlet weak var discountcodelabel: UILabel!
    
    @IBAction func Apply(_ sender: Any) {
        
        let alert = UIAlertController(title: "Success", message: "Discount has been applied!", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        if let viewController = self.parentViewController() {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

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
