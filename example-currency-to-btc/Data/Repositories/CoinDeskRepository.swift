//
//  CoinDeskRepository.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Combine
import Moya

protocol CoinDeskRepository {
    func getCurrentPrice() -> AnyPublisher<CurrentPriceResponse?, MoyaError>
}

final class CoinDeskRepositoryImpl: CoinDeskRepository {
    
    private let provider: MoyaProvider<CoinDeskAPI>
    
    init(provider: MoyaProvider<CoinDeskAPI> = MoyaProvider<CoinDeskAPI>()) {
        self.provider = provider
    }
    
    func getCurrentPrice() -> AnyPublisher<CurrentPriceResponse?, MoyaError> {
        return self.provider.requestPublisher(.getCurrentPrice)
            .map(CurrentPriceResponse?.self)
    }
}
