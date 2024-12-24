//
//  SearchPage.swift
//  ReLeaf
//
//  Created by Bader on 24/12/2024.
//

import UIKit

class SearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   // func updateSearchResults(for searchController: UISearchController) {
  //      <#code#>
//    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Label1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchPageTableViewCell
        cell?.ProductImage.image = UIImage(named: ProductImage[indexPath.row])

        cell?.Label1.text = Label1[indexPath.row]
        cell?.Label2.text = Label2[indexPath.row]
        return cell!
        
    }
    

    @IBOutlet weak var searchtableview: UITableView!
    @IBOutlet weak var Searchbar: UISearchBar!
    
    
    var Label1 = ["Bamboo ToothBrush", "Reusable water bottle ", "bamboo straws"]
    
    var ProductImage = ["image1", "image2", "image3", "image4"]
    
    var Label2 = ["10 bd", "12 bd", "13 bd", "10 bd"]
    
    var filterData = [String]()
    var searchbarController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData = Label1
        searchbarController = UISearchController (searchResultsController: nil)
        searchbarController.searchBar.delegate = self
        searchbarController.searchBar.placeholder = "Search here..."
        searchbarController.obscuresBackgroundDuringPresentation = false
        self.Searchbar.delegate = self
        self.searchtableview.delegate = self
        self.searchtableview.dataSource = self
        
      //  tableView.tableHeaderView = searchbarController.searchBar
   
    }
    

    }
    
extension SearchPage {
    
    func searchResultUpdate (for searchbarcontroller: UISearchController){
        
        guard let textField = searchbarcontroller.searchBar.text
        else {return}
        
        
        if textField.isEmpty {
            filterData = Label1
            
        }
        else {
            
            filterData = Label1.filter{ $0.lowercased().contains(textField.lowercased()) }
        
                
            }
        }
        
    }



