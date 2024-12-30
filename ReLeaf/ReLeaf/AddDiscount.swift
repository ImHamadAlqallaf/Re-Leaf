import UIKit

class AddDiscount: UIViewController {

    
    
 
    @IBOutlet weak var code: UITextField!
    
   
    @IBOutlet weak var discount: UITextField!
    
  
    @IBOutlet weak var expiry: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDiscountSegue" {
            let dest = segue.destination as! DiscountCards
            
            let codeText = code.text ?? ""
            let discountText = discount.text ?? ""
            let expiryText = expiry.text ?? ""

            if codeText.isEmpty || discountText.isEmpty || expiryText.isEmpty {
                print("Error: One or more fields are empty.")
                return
            }
            
            dest.addDiscount(code: codeText, discount: discountText, expiry: expiryText)
        }
    
}

    @IBAction func addCouponTapped(_ sender: Any) {
        // Trigger the segue programmatically if needed
                performSegue(withIdentifier: "addDiscountSegue", sender: self)
    }
}
