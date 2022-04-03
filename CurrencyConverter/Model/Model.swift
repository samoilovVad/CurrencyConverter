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
           print(decodedData)
        } catch {
            print(error)
        }
        
    }
    let currencies = ["BYN 🇧🇾", "RUB 🇷🇺", "USD 🇺🇸", "EUR 🇪🇺"]
    let rate = ["BYN 🇧🇾RUB 🇷🇺": 30.16, "BYN 🇧🇾USD 🇺🇸": 0.39, "BYN 🇧🇾EUR 🇪🇺": 0.34,
                "RUB 🇷🇺BYN 🇧🇾": 0.033, "RUB 🇷🇺USD 🇺🇸": 0.013, "RUB 🇷🇺EUR 🇪🇺": 0.011,
                "USD 🇺🇸BYN 🇧🇾": 3.3, "USD 🇺🇸RUB 🇷🇺": 77.44, "USD 🇺🇸EUR 🇪🇺": 0.88,
                "EUR 🇪🇺BYN 🇧🇾": 2.91, "EUR 🇪🇺RUB 🇷🇺": 87.63, "EUR 🇪🇺USD 🇺🇸": 1.13]
}
