//
//  Model.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 15.02.22.
//

import Foundation


struct Data {
    let currencies = ["BYN 🇧🇾", "RUB 🇷🇺", "USD 🇺🇸", "EUR 🇪🇺"]
    let coefficient = ["BYN 🇧🇾RUB 🇷🇺": 30.16, "BYN 🇧🇾USD 🇺🇸": 0.39, "BYN 🇧🇾EUR 🇪🇺": 0.34,
                       "RUB 🇷🇺BYN 🇧🇾": 0.033, "RUB 🇷🇺USD 🇺🇸": 0.013, "RUB 🇷🇺EUR 🇪🇺": 0.011,
                       "USD 🇺🇸BYN 🇧🇾": 3.3, "USD 🇺🇸RUB 🇷🇺": 77.44, "USD 🇺🇸EUR 🇪🇺": 0.88,
                       "EUR 🇪🇺BYN 🇧🇾": 2.91, "EUR 🇪🇺RUB 🇷🇺": 87.63, "EUR 🇪🇺USD 🇺🇸": 1.13]
}
