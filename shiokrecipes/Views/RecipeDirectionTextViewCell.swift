//
//  RecipeDirectionTextViewCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 14/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class RecipeDirectionTextViewCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var stepLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lb.widthAnchor.constraint(equalToConstant: 60).isActive = true
        lb.textColor = .darkGray
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
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
        contentView.addSubview(stepLabel)
        contentView.addSubview(textView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            textView.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
