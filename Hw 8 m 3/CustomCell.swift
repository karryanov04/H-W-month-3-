//
//  CustomCell.swift
//  Hw 8 m 3
//
//  Created by Рауль on 13/3/23.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .black
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Italic", size: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private func setupSubviews () {
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(avatarImageView.frame.width)
            make.height.equalTo(avatarImageView.frame.height)

        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(avatarImageView.snp.right).offset(14)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(avatarImageView.snp.right).offset(14)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    override func layoutSubviews() {
        setupSubviews()
    }
    
    public func displayCell(with data: Friend) {
        avatarImageView.image = data.image
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
}
