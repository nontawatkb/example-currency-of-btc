//
//  GenerateViewController.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 27/7/2566 BE.
//

import UIKit

class GenerateViewController: UIViewController {
    
    private(set) var viewModel: GenerateViewModel!
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.backgroundColor = .clear
        return view
    }()
    
    private let inputNum: UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.font = .systemFont(ofSize: 20)
        view.borderStyle = .roundedRect
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    private let headInputLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "Input number"
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
    
    private let generateButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let generateButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Generate", for: .normal)
        view.backgroundColor = .systemOrange
        view.tintColor = .white
        view.layer.cornerRadius = 5
        view.titleLabel?.font = .systemFont(ofSize: 18)
        return view
    }()
    
    override func viewDidLoad() {
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
    
    func configure(viewModel: GenerateViewModel) {
        self.viewModel = viewModel
        bindToViewModel()
    }

    private func setupUI() {
        navigationItem.title = viewModel.output.getGenerateType.title
        view.backgroundColor = .black
        view.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(headInputLabel)
        stackViewContainer.addArrangedSubview(inputNum)
        stackViewContainer.addArrangedSubview(resultHeadLabel)
        stackViewContainer.addArrangedSubview(resultLabel)
        stackViewContainer.addArrangedSubview(generateButtonView)
        self.generateButtonView.addSubview(generateButton)
        updateUIConstraints()
        
        generateButton.addTarget(self, action: #selector(handleGenerateButton(_:)), for: .touchUpInside)
    }
  
    private func updateUIConstraints() {
        let guide = view.safeAreaLayoutGuide
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        stackViewContainer.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        inputNum.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.topAnchor.constraint(equalTo: generateButtonView.topAnchor).isActive = true
        generateButton.centerXAnchor.constraint(equalTo: generateButtonView.centerXAnchor).isActive = true
        generateButton.bottomAnchor.constraint(equalTo: generateButtonView.bottomAnchor).isActive = true
        
        generateButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        generateButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    @objc func handleGenerateButton(_ sender: UIButton) {
        if let num = Int(inputNum.text ?? "") {
            viewModel.input.generate(num: num)
        } else {
            resultLabel.textColor = .red
            resultLabel.text = "Input Error!"
        }
    }
    
}

// MARK: - Binding
extension GenerateViewController {
    func bindToViewModel() {
        viewModel.output.didUpdateGenerateValue = didUpdateGenerateValue()
    }
    
    func didUpdateGenerateValue() -> (([Int]) -> Void) {
        return { [weak self] result in
            guard let self = self else { return }
            resultLabel.textColor = .green
            resultLabel.text = result.description
        }
    }
  
}

