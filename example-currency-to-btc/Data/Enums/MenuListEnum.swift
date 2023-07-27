//
//  MenuListEnum.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation

enum MenuListEnum {
    case currencyBTC
    case validatePincode
    case generateFibonacci
    case generatePrimeNumber
    
    var title: String {
        switch self {
        case .currencyBTC:
            return "Currency BTC"
        case .validatePincode:
            return "Validate Pincode"
        case .generateFibonacci:
            return "Generate Fibonacci"
        case .generatePrimeNumber:
            return "Generate PrimeNumber"
        }
    }
}
