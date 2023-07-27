//
//  CoinDeskAPI.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation
import Moya
import UIKit

public enum CoinDeskAPI {
    case getCurrentPrice
}

extension CoinDeskAPI: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.coindesk.com/v1/bpi")!
        }
    }

    public var path: String {
        switch self {
        case .getCurrentPrice:
            return "/currentprice.json"
        }
    }

    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
//        switch self {
//        case .getSearch:
//            return GetJsonFile.shared.readLocalFile(forName: "SearchResponse")
//        }
    }

    public var task: Task {
        switch self {
        case .getCurrentPrice:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? { return nil }

}


