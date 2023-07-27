//
//  CurrencyViewModel.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Combine
import Foundation
import UIKit

protocol CurrencyProtocolInput {
    func getCurentPrice()
    
    func didSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

protocol CurrencyProtocolOutput: AnyObject {
    var didUpdateCurrentPrice: (() -> Void)? { get set }
    var didUpdateTimer: (() -> Void)? { get set }
    var didUpdateCalCurrency: (() -> Void)? { get set }
    
    var selectedCurrency: CurrentPriceItem? { get }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func getNumberOfItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func getCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol CurrencyProtocol {
    var input: CurrencyProtocolInput { get }
    var output: CurrencyProtocolOutput { get }
}

class CurrencyViewModel: CurrencyProtocol {
    
    var input: CurrencyProtocolInput { return self }
    var output: CurrencyProtocolOutput { return self }
    
    // MARK: - UseCase
    private let getCurrentPriceUseCase: GetCurrentPriceUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var listCurrentPrice: [CurrentPriceItem] = []
    private var listHistoryCurrency: [CurrentPriceResponse] = []
    private var searchText: String?
    private var selectMenuIndex: Int = 0
    private var isFristLoadCurrentPrice: Bool = true
    
    init(getCurrentPriceUseCase: GetCurrentPriceUseCase = GetCurrentPriceUseCaseImpl()) {
        self.getCurrentPriceUseCase = getCurrentPriceUseCase
        self.setupListCurrentPrice()
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
    }
    
    private func setupListCurrentPrice() {
        listCurrentPrice.append(CurrentPriceItem(code: "USD"))
        listCurrentPrice.append(CurrentPriceItem(code: "GBP"))
        listCurrentPrice.append(CurrentPriceItem(code: "EUR"))
    }
    
    // MARK: - Data-binding OutPut
    var didUpdateCurrentPrice: (() -> Void)?
    var didUpdateTimer: (() -> Void)?
    var didUpdateCalCurrency: (() -> Void)?
    
    private func updateCurrentPrice() {
        guard let currentPrice = self.listHistoryCurrency.first else { return }
        updateItemCurrentPrice(code: "USD", currentItem: currentPrice.dictionaryPriceItem?["USD"])
        updateItemCurrentPrice(code: "GBP", currentItem: currentPrice.dictionaryPriceItem?["GBP"])
        updateItemCurrentPrice(code: "EUR", currentItem: currentPrice.dictionaryPriceItem?["EUR"])
    }
    
    private func updateItemCurrentPrice(code: String, currentItem: CurrentPriceItem?) {
        guard let index = self.listCurrentPrice.firstIndex(where: { $0.code == code}),
              let currentItem = currentItem else { return }
        self.listCurrentPrice[index] = currentItem
    }
}

// MARK: - Input
extension CurrencyViewModel: CurrencyProtocolInput {
    func getCurentPrice() {
        self.getCurrentPriceUseCase.execute()
            .sink(receiveCompletion: { _ in
                self.updateCurrentPrice()
                self.didUpdateCurrentPrice?()
                self.didUpdateTimer?()
                self.updateCurrentPrice()
                if self.isFristLoadCurrentPrice {
                    self.didUpdateCalCurrency?()
                }
                self.isFristLoadCurrentPrice = false
            }, receiveValue: { response in
                guard let response = response else { return }
                self.listHistoryCurrency.insert(response, at: 0)
            })
            .store(in: &anyCancellable)
    }
    
    func didSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectMenuIndex != indexPath.row else { return }
        selectMenuIndex = indexPath.row
        didUpdateCalCurrency?()
        didUpdateCurrentPrice?()
    }
}

// MARK: - OutPut
extension CurrencyViewModel: CurrencyProtocolOutput {
    
    var selectedCurrency: CurrentPriceItem? {
        return self.listCurrentPrice[selectMenuIndex]
    }
    
    // MARK: - Table View
    func getNumberOfRowsInSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listHistoryCurrency.count
    }
    
    func getCellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        let currentPrice = self.listHistoryCurrency[indexPath.row]
        cell.currentPriceTime = currentPrice.time
        if let code = self.listCurrentPrice[selectMenuIndex].code {
            cell.currentPriceItem = currentPrice.dictionaryPriceItem?[code]
        }
        return cell
    }
    
    // MARK: - Collection View
    func getNumberOfItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listCurrentPrice.count
    }
    
    func getCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        let code = self.listCurrentPrice[indexPath.row].code ?? ""
        cell.titleName = !code.isEmpty ? "\(code)/BTC" : "-"
        cell.currentPriceItem = self.listCurrentPrice[indexPath.row]
        cell.isSelectedCell = selectMenuIndex == indexPath.row ? true : false
        return cell
    }

}

