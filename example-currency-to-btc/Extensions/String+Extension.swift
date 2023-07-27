//
//  String+Extension.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func isDuplicateMoreThan2() -> Bool {
        var countDuplicate = 1
        var lastChar: Character?
        for char in self {
            if char == lastChar {
                countDuplicate = countDuplicate + 1
            } else {
                countDuplicate = 1
            }
            lastChar = char
            
            if countDuplicate >= 3 {
                return true
            }
        }
        return false
    }
    
    func isSortMoreThan2() -> Bool {
        var countNext = 1
        var countPrevious = 1
        var lastNum: Int?
        
        for char in self {
            if let num = Int(String(char)) {
                if num + 1 == lastNum {
                    countNext = countNext + 1
                    countPrevious = 1
                } else if num - 1 == lastNum {
                    countPrevious = countPrevious + 1
                    countNext = 1
                } else {
                    countNext = 1
                    countPrevious = 1
                }
                
                if countPrevious >= 3 || countNext >= 3 {
                    return true
                }
                lastNum = num
            }
        }
        return false
    }
    
    func isDuplicateGroupMoreThan2() -> Bool {
        var countDuplicateGroup = 0
        var lastChar: Character?
        for char in self {
            if char == lastChar {
                countDuplicateGroup = countDuplicateGroup + 1
            }
            if countDuplicateGroup >= 3 {
                return true
            }
            lastChar = char
        }
        return false
    }
    
    func isNumber() -> Bool {
        for char in self {
            if !char.isNumber {
                return false
            }
        }
        return true
    }
}
