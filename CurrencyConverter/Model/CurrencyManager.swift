//
//  Model.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 15.02.22.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didUpdateRate(_ currencyManager: CurrencyManager, currencyRate: CurrencyModel)
    func didFailWithError(error: Error)
}

struct CurrencyManager {
    
    let currencyURL = "https://www.floatrates.com/daily/"
    
    var delegate: CurrencyManagerDelegate?
    
    func fetchCurrencyRate(name: String, currency: String) {
        let urlString = "\(currencyURL)\(name)"
        performRequest(with: urlString, currency)
    }
    
    func performRequest(with urlString: String, _ currency: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, session, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let currencyRate = self.parseJSON(safeData, currency) {
                        self.delegate?.didUpdateRate(self, currencyRate: currencyRate)
                    }
                }
            }
            // 4. Start a task
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data, _ currency: String) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            var rate: Double?
            switch currency {
            case "rub": rate = (decodedData.rub?.rate)!
            case "byn": rate = (decodedData.byn?.rate)!
            case "usd": rate = (decodedData.usd?.rate)!
            case "eur": rate = (decodedData.eur?.rate)!
            default: print("error")
            }
            let currencyRate = CurrencyModel(rate: rate, nameOfCurrency: currency)
            return currencyRate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    let currencies = ["usd", "rub", "byn", "eur"]
}


