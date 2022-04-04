//
//  Model.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 15.02.22.
//

import Foundation


struct CurrencyManager {
    
    let currencyURL = "https://www.floatrates.com/daily/"
    
    func fetchCurrencyRate(name: String) {
        let urlString = "\(currencyURL)\(name)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, session, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(currencyData: safeData)
                }
            }
            // 4. Start a task
            task.resume()
        }
    }
    
    func parseJSON(currencyData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            print(decodedData.rub?.inverseRate)
        } catch {
            print(error)
        }
        
    }
    let currencies = ["usd", "rub", "cad", "eur"]
    let rate = ["cadrub": 30.16, "cadusd": 0.39, "cadeur": 0.34,
                "rubcad": 0.033, "rubusd": 0.013, "rubeur": 0.011,
                "usdcad": 3.3, "usdrub": 77.44, "usdeur": 0.88,
                "eurcad": 2.91, "eurrub": 87.63, "eurusd": 1.13]
}
