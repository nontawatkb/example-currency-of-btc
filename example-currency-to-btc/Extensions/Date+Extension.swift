//
//  Date+Extension.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation

extension Date {
    
    func toStringFormatted(format: String) -> String? {
        let dateformat = DateFormatter()
       dateformat.dateFormat = format
       dateformat.timeZone = NSTimeZone.local
       return dateformat.string(from: self)
    }

}
