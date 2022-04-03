//
//  currencyData.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 3.04.22.
//

import Foundation

struct Currency: Decodable {
    let code: String
    let alphaCode: String
    let numericCode: String
    let name: String
    let rate: Double
    let date: String
    let inverseRate: Double
}

struct CurrencyData: Decodable {
    let eur: Currency?
}


