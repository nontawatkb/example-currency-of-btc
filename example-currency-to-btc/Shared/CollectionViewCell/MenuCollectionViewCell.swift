//
//  MenuCollectionViewCell.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation
import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
    
    var currentPriceItem: CurrentPriceItem? {
        didSet {
            setupValue()
        }
    }
    
    var titleName: String? {
        didSet {
            titleLabel.text = titleName ?? ""
        }
    }
  
    var isSelectedCell: Bool = false {
        didSet {
            backgroundColor = isSelectedCell ? .red : .clear
        }
    }
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .boldSystemFont(ofSize: 19)
        view.textColor = .white
        view.textAlignment = .center
        view.text = ""
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 16)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "-"
        return view
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 5
        self.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(titleLabel)
        stackViewContainer.addArrangedSubview(priceLabel)
        self.updateUIConstraints()
    }
    
    private func updateUIConstraints() {
        let guide = safeAreaLayoutGuide
        self.stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8).isActive = true
        self.stackViewContainer.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8).isActive = true
        self.stackViewContainer.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8).isActive = true
        self.stackViewContainer.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant:  -8).isActive = true
    }
    
    private func setupValue() {
        guard let currentPriceItem = currentPriceItem,
              let rate = currentPriceItem.rate  else { return }
        let symbol = currentPriceItem.symbol?.htmlToString ?? ""
        priceLabel.text = "\(symbol)\(rate)"
    }
}


