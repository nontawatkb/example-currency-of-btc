//
//  Int+Extension.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 27/7/2566 BE.
//

import Foundation

extension Int {
    
    func checkPrimeNumber() -> Bool {
        guard self != 1 && self != 0 else { return false }
        for j in 2..<self{
            if (self % j == 0){
                return false
            }
        }
        return true
    }
    
    func getFibonacci() -> Int {
        var a = 0
        var b = 1
        var temp = 0
        for _ in 0..<self {
            temp = a + b
            a = b
            b = temp
        }
        return b
    }
    
}
