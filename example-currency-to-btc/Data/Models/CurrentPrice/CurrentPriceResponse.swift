//
//  CurrentPriceResponse.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation

public struct CurrentPriceResponse: Codable {
    
    public var time: CurrentPriceTime?
    public var disclaimer: String?
    public var chartName: String?
    public var dictionaryPriceItem: [String: CurrentPriceItem]?
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case disclaimer = "disclaimer"
        case chartName = "chartName"
        case dictionaryPriceItem = "bpi"
    }
}

public struct CurrentPriceTime: Codable {
    
    public var updated: String?
    public var updatedISO: String?
    public var updateduk: String?
    
    enum CodingKeys: String, CodingKey {
        case updated = "updated"
        case updatedISO = "updatedISO"
        case updateduk = "updateduk"
    }
}

public struct CurrentPriceItem: Codable {
    
    public var code: String?
    public var symbol: String?
    public var rate: String?
    public var description: String?
    public var rateFloat: Float?
    
    public init(code: String?,
                symbol: String? = nil,
                rate: String? = nil,
                description: String? = nil,
                rateFloat: Float? = nil) {
        self.code = code
        self.symbol = symbol
        self.rate = rate
        self.description = description
        self.rateFloat = rateFloat
    }
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rateFloat = "rate_float"
    }
}

