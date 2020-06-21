//
//  SettingsTextFieldCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 21/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class SettingsTextFieldCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 13)
        lb.textColor = .darkGray
        return lb
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        textField.font = .systemFont(ofSize: 14)
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
        contentView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            contentView.heightAnchor.constraint(equalToConstant: 60),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
}
