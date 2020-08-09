//
//  RecipeDetailDescriptionCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 9/8/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class RecipeDetailDescriptionCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var dishNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 58).isActive = true
        lb.font = Constants.Design.Font.newYorkMedium.withSize(24)
        lb.textColor = .black
        return lb
    }()
    
    lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 284).isActive = true
        return imageView
    }()
    
    lazy var authorNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lb.font = Constants.Design.Font.newYorkRegular.withSize(13)
        lb.textColor = .black
        return lb
    }()
    
    lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        imageView.image = UIImage(named: "person_circle")
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 80).isActive = true
        lb.font = Constants.Design.Font.newYorkRegular.withSize(13)
        lb.textColor = .black
        lb.numberOfLines = 0
        return lb
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
        self.backgroundColor = .clear
        contentView.addSubview(dishNameLabel)
        contentView.addSubview(dishImageView)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(profilePic)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dishNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dishNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dishNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            dishImageView.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 10),
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            authorNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),
            authorNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),
            
            profilePic.centerYAnchor.constraint(equalTo: authorNameLabel.centerYAnchor),
            profilePic.trailingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
}
