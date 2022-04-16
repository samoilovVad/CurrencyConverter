//
//  ViewControllerCurrencyPick.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 16.04.22.
//

import UIKit

class ViewControllerCurrencyPick: UIViewController {
    

    @IBOutlet var tableView: UITableView!
    let currencyManager = CurrencyManager()
    var text: String?
    public var completionHandler: ((String?) -> Void)?
    public var numberOfField = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func buttonSelect() {
        completionHandler?(text)
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate
extension ViewControllerCurrencyPick: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text = currencyManager.currencies[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension ViewControllerCurrencyPick: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyManager.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(24))
        var flag: String {
            switch currencyManager.currencies[indexPath.row] {
            case "eur": return "🇪🇺"
            case "usd": return "🇺🇸"
            case "rub": return "🇷🇺"
            default: return "🇧🇾"
            }
        }
        cell.textLabel?.text = "\(currencyManager.currencies[indexPath.row]) \(flag)"
        
        return cell
    }
    
    
}
