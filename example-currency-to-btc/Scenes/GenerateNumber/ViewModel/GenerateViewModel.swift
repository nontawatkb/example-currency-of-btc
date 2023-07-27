//
//  GenerateViewModel.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 27/7/2566 BE.
//

import Combine
import Foundation
import UIKit

protocol GenerateProtocolInput {
    func generate(num: Int)
}

protocol GenerateProtocolOutput: AnyObject {
    
    var didUpdateGenerateValue: (([Int]) -> Void)? { get set}
    
    var getGenerateType: GenerateType { get }
}

protocol GenerateProtocol {
    var input: GenerateProtocolInput { get }
    var output: GenerateProtocolOutput { get }
}

class GenerateViewModel: GenerateProtocol {
    
    var input: GenerateProtocolInput { return self }
    var output: GenerateProtocolOutput { return self }
    
    // MARK: - UseCase
//    private let getCurrentPriceUseCase: GetCurrentPriceUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    
    private let generateType: GenerateType
    
    init(generateType: GenerateType) {
        self.generateType = generateType
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
    }
    
    // MARK: - Data-binding OutPut
    var didUpdateGenerateValue: (([Int]) -> Void)?
    
}

// MARK: - Input
extension GenerateViewModel: GenerateProtocolInput {
    func generate(num: Int) {
        if generateType == .generatePrimeNumber {
            generatePrimeNumber(num: num)
        } else if generateType == .generateFibonacci {
            generateFibonacci(num: num)
        } else {
            
        }
    }
    
    private func generatePrimeNumber(num: Int) {
        var listNumber: [Int] = []
        var i = 0
        while (listNumber.count != num) {
            if i.checkPrimeNumber() {
                listNumber.append(i)
            }
            i = i + 1
        }
        self.didUpdateGenerateValue?(listNumber)
    }
    
    
    func generateFibonacci(num: Int) {
        var listNumber: [Int] = []
        for i in 0..<num {
            listNumber.append(i.getFibonacci())
        }
        self.didUpdateGenerateValue?(listNumber)
    }
}

// MARK: - OutPut
extension GenerateViewModel: GenerateProtocolOutput {
    var getGenerateType: GenerateType {
        return generateType
    }
}



