//
//  MainTableViewCell.swift
//  example-currency-to-btc
//
//  Created by Nontawat Kanboon on 25/7/2566 BE.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    var titleName: String? {
        didSet {
            titleLabel.text = titleName ?? ""
        }
    }
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 21)
        view.textColor = .white
        return view
    }()
    
    private let arrowRightImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrowshape.right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
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
        stackViewContainer.addArrangedSubview(titleLabel)
        stackViewContainer.addArrangedSubview(arrowRightImageView)
        addSubview(stackViewContainer)
        updateUIConstraints()
    }
    
    private func updateUIConstraints() {
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        arrowRightImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}


