import UIKit

class ImpactMetricDashboardViewController: UIViewController {
    
    @IBOutlet weak var lblCO2EmissionSaved: UILabel!
    @IBOutlet weak var lblWaterConserved: UILabel!
    @IBOutlet weak var lblWasteReduced: UILabel!
    @IBOutlet weak var lblPlasticWasteReduced: UILabel!
    @IBOutlet weak var lblTreesSaved: UILabel!
    @IBOutlet weak var btnReloadData: UIButton!
    
    var metrics: [Metric] = []
    
    @IBAction func reloadDataTapped(_ sender: UIButton) {
        loadMetricsData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMetricsData()
    }
    
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    
    func loadMetricsData() {
        guard let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") else {
            print("localData.json not found!")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(Wrapper.self, from: data)
            self.metrics = wrapper.metrics ?? []
            updateUI()
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
    
    func updateUI() {
        for metric in metrics {
            switch metric.name {
            case "CO2 Emission Saved":
                lblCO2EmissionSaved.text = "\(metric.value)"
            case "Water Conserved":
                lblWaterConserved.text = "\(metric.value)"
            case "Waste Reduced":
                lblWasteReduced.text = "\(metric.value)"
            case "Plastic Waste Reduced":
                lblPlasticWasteReduced.text = "\(metric.value)"
            case "Trees Saved":
                lblTreesSaved.text = "\(metric.value)"
            default:
                break
            }
        }
    }
}
