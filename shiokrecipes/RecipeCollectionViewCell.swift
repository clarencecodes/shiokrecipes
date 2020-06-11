//
//  RecipeCollectionViewCell.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 11/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lb.font = Constants.Design.Font.newYorkBold.withSize(13)
        lb.textColor = .white
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var authorNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 13).isActive = true
        lb.font = Constants.Design.Font.newYorkRegular.withSize(13)
        lb.textColor = .white
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
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.addSubview(dishImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(profilePic)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            profilePic.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            profilePic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 5),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorNameLabel.centerYAnchor.constraint(equalTo: profilePic.centerYAnchor)
        ])
    }
    
    
}
