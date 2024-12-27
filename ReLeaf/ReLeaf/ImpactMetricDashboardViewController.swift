import UIKit



class ImpactMetricDashboardViewController: UIViewController {

    @IBOutlet weak var btnReloadData: UIButton!
    
    @IBOutlet weak var lblStaticCO2EmissionSaved: UILabel!
    @IBOutlet weak var lblStaticWaterConserved: UILabel!
    @IBOutlet weak var lblStaticWasteReduced: UILabel!
    @IBOutlet weak var lblStaticPlasticWasteReduced: UILabel!
    @IBOutlet weak var lblStaticTreesSaved: UILabel!
    
    @IBOutlet weak var lblCO2EmissionSaved: UILabel!
    @IBOutlet weak var lblWaterConserved: UILabel!
    @IBOutlet weak var lblWasteReduced: UILabel!
    @IBOutlet weak var lblPlasticWasteReduced: UILabel!
    @IBOutlet weak var lblTreesSaved: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMetricsData()

    }
    
    
    
    @IBAction func reloadDataTapped(_ sender: UIButton) {
        loadMetricsData()
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
            
            if let metrics = wrapper.metrics?.impact {
                updateLabels(with: metrics)
            } else {
                createDefaultMetrics()
            }
        } catch {
            print("Error loading or decoding JSON: \(error)")
            createDefaultMetrics()
        }
    }
    
    func updateLabels(with metrics: [Metric]) {
        for metric in metrics {
            switch metric.name {
            case "CO2 Emission Saved":
                lblCO2EmissionSaved.text = "\(metric.value) kg"
            case "Water Conserved":
                lblWaterConserved.text = "\(metric.value) liters"
            case "Waste Reduced":
                lblWasteReduced.text = "\(metric.value) kg"
            case "Plastic Waste Reduced":
                lblPlasticWasteReduced.text = "\(metric.value) kg"
            case "Trees Saved":
                lblTreesSaved.text = "\(metric.value)"
            default:
                break
            }
        }
    }
    
    func createDefaultMetrics() {
        lblCO2EmissionSaved.text = "0 kg"
        lblWaterConserved.text = "0 liters"
        lblWasteReduced.text = "0 kg"
        lblPlasticWasteReduced.text = "0 kg"
        lblTreesSaved.text = "0"
    }
    
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
}
