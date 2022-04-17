//
//  ViewControllerCurrencyPick.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 16.04.22.
//

import UIKit

class ViewControllerCurrencyPick: UIViewController {
    

    @IBOutlet var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarIsEmpty
    }
    let currencyManager = CurrencyManager()
    var text: String?
    public var completionHandler: ((String?) -> Void)?
    private var filteredCurrencies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup the searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search currency"
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

}

// MARK: - UITableViewDelegate
extension ViewControllerCurrencyPick: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var currency: [String] {
            if isFiltering {
                return filteredCurrencies
            } else {
                return currencyManager.currencies
            }
        }
        
        text = currency[indexPath.row]
        completionHandler?(text)
        if isFiltering {
            dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
}

// MARK: - UITableViewDataSource
extension ViewControllerCurrencyPick: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCurrencies.count
        }
        return currencyManager.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var currency: [String] {
            if isFiltering {
                return filteredCurrencies
            } else {
                return currencyManager.currencies
            }
        }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(24))
        var flag: String {
            switch currency[indexPath.row] {
            case "eur": return "🇪🇺"
            case "usd": return "🇺🇸"
            case "rub": return "🇷🇺"
            default: return "🇧🇾"
            }
        }
        cell.textLabel?.text = "\(currency[indexPath.row]) \(flag)"
        
        return cell
    }
}

// MARK: - UISearchController
extension ViewControllerCurrencyPick: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterForSearchText(searchController.searchBar.text!)
    }
    
    private func filterForSearchText(_ searchText: String) {
        filteredCurrencies = currencyManager.currencies.filter( { (currency: String) -> Bool in
            return currency.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
