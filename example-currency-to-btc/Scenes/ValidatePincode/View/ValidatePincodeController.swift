//
//  ValidatePincodeController.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 26/7/2566 BE.
//

import UIKit

class ValidatePincodeController: UIViewController {
    
    private(set) var viewModel: ValidatePincodeViewModel!
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.backgroundColor = .clear
        return view
    }()
    
    private let inputCurrency: UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.font = .systemFont(ofSize: 20)
        view.borderStyle = .roundedRect
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    private let pinCodeHeadLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "Validator Pin Code"
        return view
    }()
    
    private let resultHeadLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "Result"
        return view
    }()
    
    private let resultLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textColor = .red
        view.textAlignment = .center
        view.text = "-"
        view.numberOfLines = 0
        return view
    }()

    private let validateButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Validate", for: .normal)
        view.backgroundColor = .systemOrange
        view.tintColor = .white
        view.layer.cornerRadius = 5
        view.titleLabel?.font = .systemFont(ofSize: 18)
        return view
    }()
    
    override func viewDidLoad() {
        configure()
        setupUI()
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        updateUIConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func configure() {
        viewModel = ValidatePincodeViewModel()
        bindToViewModel()
    }

    private func setupUI() {
        navigationItem.title = "Validate Pincode"
        view.backgroundColor = .black
        view.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(pinCodeHeadLabel)
        stackViewContainer.addArrangedSubview(inputCurrency)
        stackViewContainer.addArrangedSubview(resultHeadLabel)
        stackViewContainer.addArrangedSubview(resultLabel)
        stackViewContainer.addArrangedSubview(validateButton)
        updateUIConstraints()
        
        validateButton.addTarget(self, action: #selector(handleValidatorPinCode(_:)), for: .touchUpInside)
    }
  
    private func updateUIConstraints() {
        let guide = view.safeAreaLayoutGuide
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        stackViewContainer.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        inputCurrency.heightAnchor.constraint(equalToConstant: 45).isActive = true
        validateButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func handleValidatorPinCode(_ sender: UIButton) {
        viewModel.input.validatePinCode(pinCode: inputCurrency.text ?? "")
    }
    
}

// MARK: - Binding
extension ValidatePincodeController {
    func bindToViewModel() {
        viewModel.output.didUpdateStatusValidate = didUpdateStatusValidate()
    }
    
    func didUpdateStatusValidate() -> ((Bool, String) -> Void) {
        return { [weak self] status, text in
            guard let self = self else { return }
            resultLabel.textColor = status == true ? .green : .red
            resultLabel.text = text
        }
    }
  
}
