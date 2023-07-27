//
//  MainViewController.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation
import UIKit

class MainViewController: UITableViewController {
    
    let listMenuMain: [MenuListEnum] = [.currencyBTC, .validatePincode, ]
    let listMenuBonus: [MenuListEnum] = [.generateFibonacci, .generatePrimeNumber]

    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Menu"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.listMenuMain.count : self.listMenuBonus.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        if indexPath.section == 0 {
            cell.titleName = listMenuMain[indexPath.row].title
        } else {
            cell.titleName = listMenuBonus[indexPath.row].title
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var menu: MenuListEnum?
        if indexPath.section == 0 {
            menu = listMenuMain[indexPath.row]
        } else {
            menu = listMenuBonus[indexPath.row]
        }
        switch menu {
        case .currencyBTC:
            self.navigationController?.pushViewController(CurrencyViewController(), animated: true)
        case .validatePincode:
            self.navigationController?.pushViewController(ValidatePincodeController(), animated: true)
        case .generatePrimeNumber:
            let viewModel = GenerateViewModel(generateType: .generatePrimeNumber)
            let viewController = GenerateViewController()
            viewController.configure(viewModel: viewModel)
            self.navigationController?.pushViewController(viewController, animated: true)
        case .generateFibonacci:
            let viewModel = GenerateViewModel(generateType: .generateFibonacci)
            let viewController = GenerateViewController()
            viewController.configure(viewModel: viewModel)
            self.navigationController?.pushViewController(viewController, animated: true)
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Main"
        } else {
            return "Bonus"
        }
    }
}


