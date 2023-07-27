//
//  Double+Extension.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation

extension Float {
    
    func toStringCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 6
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))
        return formattedNumber ?? ""
    }
}
