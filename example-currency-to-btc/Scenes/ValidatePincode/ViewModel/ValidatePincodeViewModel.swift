//
//  ValidatePincodeViewModel.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 26/7/2566 BE.
//

import Combine
import Foundation
import UIKit

protocol ValidatePincodeProtocolInput {
    func validatePinCode(pinCode: String)
}

protocol ValidatePincodeProtocolOutput: AnyObject {
    
    var didUpdateStatusValidate: ((Bool, String) -> Void)? { get set}
}

protocol ValidatePincodeProtocol {
    var input: ValidatePincodeProtocolInput { get }
    var output: ValidatePincodeProtocolOutput { get }
}

class ValidatePincodeViewModel: ValidatePincodeProtocol {
    
    var input: ValidatePincodeProtocolInput { return self }
    var output: ValidatePincodeProtocolOutput { return self }
    
    // MARK: - UseCase
//    private let getCurrentPriceUseCase: GetCurrentPriceUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    
    init() {
        
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
    }
    
    // MARK: - Data-binding OutPut
    var didUpdateStatusValidate: ((Bool, String) -> Void)?
    
}

// MARK: - Input
extension ValidatePincodeViewModel: ValidatePincodeProtocolInput {
    func validatePinCode(pinCode: String) {
        guard pinCode.isNumber() else {
            didUpdateStatusValidate?(false, "Pin code require number only.")
            return
        }
        guard pinCode.count >= 6 else {
            didUpdateStatusValidate?(false, "Pin code require count greater than or equal to 6.")
            return
        }
        
        guard !pinCode.isDuplicateMoreThan2() else {
            didUpdateStatusValidate?(false, "Pin code must duplicate not more than 2  numbers.")
            return
        }

        guard !pinCode.isSortMoreThan2() else {
            didUpdateStatusValidate?(false, "Pin code must sort not more than 2 numbers.")
            return
        }
        
        guard !pinCode.isDuplicateGroupMoreThan2() else {
            didUpdateStatusValidate?(false, "Pin code must duplicate group not more than 2 numbers.")
            return
        }
        didUpdateStatusValidate?(true, "Pin code is correct.")
    }
}

// MARK: - OutPut
extension ValidatePincodeViewModel: ValidatePincodeProtocolOutput {
    
}


