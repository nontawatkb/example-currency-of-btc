//
//  CalculatorCurrencyToBTCView.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation
import Kingfisher
import UIKit

public class CalculatorCurrencyToBTCView: UIView {
    
    var currentPriceItem: CurrentPriceItem?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .boldSystemFont(ofSize: 19)
        view.textColor = .white
        view.textAlignment = .center
        view.text = ""
        return view
    }()
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.backgroundColor = .clear
        return view
    }()
    
    private let stackInputView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        view.backgroundColor = .clear
        view.distribution = .fillEqually
        return view
    }()
    
    private let stackInputCurrency: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.backgroundColor = .clear
        view.distribution = .fillEqually
        return view
    }()
    
    private let stackResultBTC: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.backgroundColor = .clear
        view.distribution = .fillEqually
        return view
    }()
    
    private let inputCurrency: UITextField = {
        let view = UITextField()
        view.keyboardType = .decimalPad
        view.backgroundColor = .white
        view.font = .systemFont(ofSize: 18)
        view.borderStyle = .roundedRect
        view.textColor = .black
        view.textAlignment = .right
        return view
    }()
    
    private let inputResultBTC: UITextField = {
        let view = UITextField()
        view.keyboardType = .decimalPad
        view.backgroundColor = .lightText
        view.font = .systemFont(ofSize: 18)
        view.borderStyle = .roundedRect
        view.textColor = .green
        view.isEnabled = false
        view.textAlignment = .center
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .white
        view.textAlignment = .center
        view.text = ""
        return view
    }()
    
    private let resultLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "BTC"
        return view
    }()
    
    private let calButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Calculate", for: .normal)
        view.backgroundColor = .systemGreen
        view.tintColor = .white
        view.layer.cornerRadius = 5
        view.titleLabel?.font = .systemFont(ofSize: 16)
        return view
    }()

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateUIConstraints()
    }
    
    private func setupUI() {
        self.addSubview(stackViewContainer)
        self.addSubview(calButton)
        stackViewContainer.addArrangedSubview(titleLabel)
        stackViewContainer.addArrangedSubview(stackInputView)
        stackInputView.addArrangedSubview(stackInputCurrency)
        stackInputView.addArrangedSubview(stackResultBTC)
        
        stackInputCurrency.addArrangedSubview(inputCurrency)
        stackInputCurrency.addArrangedSubview(currencyLabel)
        
        stackResultBTC.addArrangedSubview(inputResultBTC)
        stackResultBTC.addArrangedSubview(resultLabel)
        calButton.addTarget(self, action: #selector(handleCalculate(_:)), for: .touchUpInside)
        self.updateUIConstraints()
    }
    
    private func updateUIConstraints() {
        let guide = safeAreaLayoutGuide
        self.stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8).isActive = true
        self.stackViewContainer.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8).isActive = true
        self.stackViewContainer.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8).isActive = true
//        self.stackViewContainer.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant:  -8).isActive = true
        inputCurrency.heightAnchor.constraint(equalToConstant: 40).isActive = true
        inputResultBTC.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.calButton.translatesAutoresizingMaskIntoConstraints = false
        self.calButton.topAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: 0).isActive = true
//        self.calButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8).isActive = true
//        self.calButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8).isActive = true
        self.calButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant:  -8).isActive = true
        self.calButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.calButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.calButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    }
    
    func updateChangeCurrency() {
        guard let currentPriceItem = currentPriceItem else { return }
        titleLabel.text = "Exchange \(currentPriceItem.code ?? "") to BTC"
        inputCurrency.text = ""
        inputResultBTC.text = ""
        
        currencyLabel.text = currentPriceItem.code ?? ""
        resultLabel.text = "BTC"
    }
    
    @objc func handleCalculate(_ sender: UIButton) {
        guard let currentPriceItem = currentPriceItem,
              let inputCurrencyText = inputCurrency.text, !inputCurrencyText.isEmpty,
              let numberInputCurrency = Float(inputCurrencyText),
              let rateFloat = currentPriceItem.rateFloat else {
            inputResultBTC.text = "-"
            return
        }
        let result = numberInputCurrency/rateFloat
        inputResultBTC.text = result.toStringCurrency()
        inputCurrency.endEditing(true)
    }
}


