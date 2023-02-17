//
//  UserActionCell.swift
//  Networking
//
//  Created by Artur on 07.02.2023.
//

import UIKit

class UserActionCell: UICollectionViewCell {
    
    lazy var userActionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        //label.font = label.font.withSize(30)
        //label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "Chalkduster", size: 30)
        label.numberOfLines = 2

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(userActionLabel)
        layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            userActionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userActionLabel.heightAnchor.constraint(equalToConstant: 80),
            userActionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            userActionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
