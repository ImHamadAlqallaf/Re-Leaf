import UIKit

class ProductImpactTrackerViewController: UIViewController {

   
    @IBOutlet weak var btnNextProduct: UIButton!
    @IBOutlet weak var btnPreviousProduct: UIButton!
    
    
    @IBOutlet weak var lblCO2Saved: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblPlasticReduced: UILabel!
    @IBOutlet weak var lblWaterConserved: UILabel!
    
    
    
    
    // This method is called when the button is tapped
//    @IBAction func btnTestSegueTapped(_ sender: UIButton) {
//        // Instantiate the view controller using the Storyboard ID
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use the correct storyboard name if it's different
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: "NextViewController")
//        
//        // If using a navigation controller, push the view controller onto the stack
//        navigationController?.pushViewController(nextViewController, animated: true)
//        
//        // Or if you want to present it modally, you can do:
//        // present(nextViewController, animated: true, completion: nil)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
