//
//  GenerateType.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 27/7/2566 BE.
//

import Foundation

enum GenerateType {
    case generateFibonacci
    case generatePrimeNumber
    
    var title: String {
        switch self {
        case .generateFibonacci:
            return "Generate Fibonacci"
        case .generatePrimeNumber:
            return "Generate PrimeNumber"
        }
    }
}

