//
//  SearchViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var searchListVM: SearchListViewModel!
    
    let apiManager = APIManager()
    var covidByCountry: [CovidStats] = []
    var countryToCheck: String?
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        guard let countryToCheck = self.countryToCheck else {return}
        
        searchForCovidInCountry(countryToCheck)
    }
    
    func searchForCovidInCountry(_ country: String) {
        
        apiManager.searchFor(country) { [unowned self] outcome in
            
            switch outcome {
            case .failure(let errorString):
                print(errorString)
            case .success(let data):
                do {
                    let result = try JSONParser.parse(data, type: CodivLastResultRoot.self)
                    self.covidByCountry = result.data.covid19Stats
                    
                    self.searchListVM = SearchListViewModel(countryCovidStats: self.covidByCountry)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("the result : \(self.covidByCountry)")
                } catch {
                    print("JSON Error: \(error)")
                }
            }
        }
    }
    
}
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchListVM == nil ? 0 : self.searchListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchID", for: indexPath) as? SearchTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let searchVM = self.searchListVM.searchStatAtIndex(indexPath.row)
        cell.configureCell(countryCovidStat: searchVM)
        return cell
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBartext = countrySearchBar.text else { return }
        self.countryToCheck = searchBartext.capitalized
        searchForCovidInCountry(searchBartext.capitalized)
        searchBar.resignFirstResponder()
    }
}

