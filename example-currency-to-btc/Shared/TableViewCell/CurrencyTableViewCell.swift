//
//  CurrencyTableViewCell.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation
import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrencyTableViewCell"
    
    var currentPriceItem: CurrentPriceItem? {
        didSet {
            setupValue()
        }
    }
    
    var currentPriceTime: CurrentPriceTime? {
        didSet {
            dateLabel.text = currentPriceTime?.updatedISO?.convertToDate()?.toStringFormatted(format: "dd/MM/yy HH:mm") ?? "-"
        }
    }
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 14)
        view.textColor = .white
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 14)
        view.textColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        stackViewContainer.addArrangedSubview(dateLabel)
        stackViewContainer.addArrangedSubview(priceLabel)
        addSubview(stackViewContainer)
        updateUIConstraints()
    }
    
    private func updateUIConstraints() {
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupValue() {
        guard let currentPriceItem = currentPriceItem,
              let rate = currentPriceItem.rate  else { return }
        let symbol = currentPriceItem.symbol?.htmlToString ?? ""
        priceLabel.text = "\(symbol)\(rate)"
    }
}



