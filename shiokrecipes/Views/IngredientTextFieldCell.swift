//
//  IngredientTextFieldCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 9/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class IngredientTextFieldCell: UITableViewCell {

    // MARK: - Views
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        textField.leftViewMode = .always
        textField.font = Constants.Design.Font.newYorkRegular.withSize(18)
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
        self.backgroundColor = .clear
        contentView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
