//
//  SettingsCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 20/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .black
        return lb
    }()
    
    lazy var rightChevron: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    // MARK: - Initialization
    
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
        contentView.addSubview(rightChevron)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            contentView.heightAnchor.constraint(equalToConstant: 50),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rightChevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightChevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
