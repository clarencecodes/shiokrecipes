//
//  PasswordTextFieldCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 21/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class PasswordTextFieldCell: UITableViewCell {

    // MARK: - Views
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .darkGray
        return lb
    }()
    
    lazy var secureTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 18)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // MARK: - Initialization code
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    // MARK: - View setup

    private func setupViews() {
        self.selectionStyle = .none
        contentView.addSubview(label)
        contentView.addSubview(secureTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            contentView.heightAnchor.constraint(equalToConstant: 60),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            secureTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            secureTextField.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            secureTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }

}
