//
//  AddIngredientCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 9/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class AddIngredientCell: UITableViewCell {

    // MARK: - Views
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 125).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 21).isActive = true
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 18)
        lb.text = "Add ingredient"
        return lb
    }()
    
    let plusCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .black
        return imageView
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
        contentView.addSubview(label)
        contentView.addSubview(plusCircle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -20),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusCircle.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            plusCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
