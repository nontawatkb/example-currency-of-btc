//
//  CurrencyViewController.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    private(set) var viewModel: CurrencyViewModel!
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
    
    private let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private let calculatorCurrencyToBTCView: CalculatorCurrencyToBTCView = {
        let view = CalculatorCurrencyToBTCView()
        view.isHidden = true
        return view
    }()
    
    private let keyboardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()
    
    var bottomHeightConstraint: NSLayoutConstraint? = nil
    
    private var timer: Timer?

    override func viewDidLoad() {
        configure()
        registerKeyboardObserver()
        setupUI()
        setupCollectionView()
        setupTableView()
        viewModel.getCurentPrice()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.cancelTimer()
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
        removeObserver()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        updateUIConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func configure() {
        viewModel = CurrencyViewModel()
        bindToViewModel()
    }
    
    private func setupUI() {
        navigationItem.title = "Currency BTC"
        view.backgroundColor = .black
        view.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(collectionView)
        stackViewContainer.addArrangedSubview(tableView)
        stackViewContainer.addArrangedSubview(calculatorCurrencyToBTCView)
        stackViewContainer.addArrangedSubview(keyboardView)
        updateUIConstraints()
        bottomHeightConstraint = keyboardView.heightAnchor.constraint(equalToConstant: 0)
        bottomHeightConstraint?.isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    private func setupTableView() {
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }
  
    private func updateUIConstraints() {
        let guide = view.safeAreaLayoutGuide
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func startTimer() {
        cancelTimer()
        timer = Timer.scheduledTimer(timeInterval: 61, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerAction() {
        viewModel.input.getCurentPrice()
    }
    
    func registerKeyboardObserver() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            keyboardDidUpdate(keyboardHeight: .zero)
        } else {
            keyboardDidUpdate(keyboardHeight: keyboardViewEndFrame.height - view.safeAreaInsets.bottom)
        }
    }
    
    func keyboardDidUpdate(keyboardHeight: CGFloat) {
        bottomHeightConstraint?.constant = keyboardHeight
    }
}

// MARK: - Binding
extension CurrencyViewController {
    func bindToViewModel() {
        viewModel.output.didUpdateTimer = didUpdateTimer()
        viewModel.output.didUpdateCurrentPrice = didUpdateCurrentPrice()
        viewModel.output.didUpdateCalCurrency = didUpdateCalCurrency()
    }
    
    func didUpdateTimer() -> (() -> Void) {
        return { [weak self] in
            guard let self = self else { return }
            self.startTimer()
        }
    }
    
    func didUpdateCurrentPrice() -> (() -> Void) {
        return { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.calculatorCurrencyToBTCView.currentPriceItem = viewModel.selectedCurrency
            
        }
    }
    
    func didUpdateCalCurrency() -> (() -> Void) {
        return { [weak self] in
            guard let self = self else { return }
            calculatorCurrencyToBTCView.currentPriceItem = viewModel.output.selectedCurrency
            calculatorCurrencyToBTCView.updateChangeCurrency()
            calculatorCurrencyToBTCView.isHidden = false
        }
    }
  
}

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRowsInSection(tableView, numberOfRowsInSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.output.getCellForRowAt(tableView, cellForRowAt: indexPath)
    }
}

extension CurrencyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.didSelectItemAt(collectionView, didSelectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfItemsInSection(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.output.getCellForItemAt(collectionView, cellForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double(collectionView.frame.width/3.0)
        return CGSize(width: width, height: 70)
    }
    
}

