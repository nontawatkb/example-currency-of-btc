//
//  GetCurrentPriceUseCase.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Combine
import Foundation
import Moya

protocol GetCurrentPriceUseCase {
    func execute() -> AnyPublisher<CurrentPriceResponse?, MoyaError>
}

class GetCurrentPriceUseCaseImpl: GetCurrentPriceUseCase {
    
    private let repository: CoinDeskRepository
    
    init(repository: CoinDeskRepository = CoinDeskRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<CurrentPriceResponse?, MoyaError>{
        return repository.getCurrentPrice()
    }
}

