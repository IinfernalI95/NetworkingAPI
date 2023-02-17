//
//  SympsonsCell.swift
//  Networking
//
//  Created by Artur on 14.02.2023.
//

import UIKit

class SympsonsCell: UITableViewCell {
    
    var simpsonImage: UIImageView = {
        let image = UIImageView()
        //image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var simpsonNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.font = UIFont(name: "Marker Felt", size: 17)
        label.numberOfLines = 2
        
        return label
    }()
    
    var simpsonQuoteLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        label.numberOfLines = 6
        
        return label
    }()
    
    var simpsonDirectionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCellView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initCellView() {
        addSubview(simpsonImage)
        addSubview(simpsonNameLabel)
        addSubview(simpsonQuoteLabel)
        addSubview(simpsonDirectionLabel)
        
        NSLayoutConstraint.activate([
            simpsonImage.topAnchor.constraint(equalTo: topAnchor),
            simpsonImage.leftAnchor.constraint(equalTo: leftAnchor),
            simpsonImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            simpsonImage.widthAnchor.constraint(equalToConstant: 150),
            simpsonNameLabel.topAnchor.constraint(equalTo: topAnchor),
            simpsonNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            simpsonNameLabel.leftAnchor.constraint(equalTo: simpsonImage.rightAnchor, constant: 6),
            simpsonNameLabel.heightAnchor.constraint(equalToConstant: 42),
            simpsonQuoteLabel.topAnchor.constraint(equalTo: simpsonNameLabel.bottomAnchor, constant: 8),
            simpsonQuoteLabel.leftAnchor.constraint(equalTo: simpsonNameLabel.leftAnchor),
            simpsonQuoteLabel.widthAnchor.constraint(equalTo: simpsonNameLabel.widthAnchor),
            simpsonQuoteLabel.heightAnchor.constraint(equalToConstant: 100),
            simpsonDirectionLabel.topAnchor.constraint(equalTo: simpsonQuoteLabel.bottomAnchor, constant: 8),
            simpsonDirectionLabel.leftAnchor.constraint(equalTo: simpsonQuoteLabel.leftAnchor),
            simpsonDirectionLabel.widthAnchor.constraint(equalTo: simpsonQuoteLabel.widthAnchor),
            simpsonDirectionLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configure(with sympson: Sympson) {
        simpsonNameLabel.text = sympson.character ?? "nil"
        simpsonDirectionLabel.text = "\(sympson.characterDirection ?? "nil")"
        simpsonQuoteLabel.text = "Quite - \(sympson.quote ?? "nil")"

        DispatchQueue.global().async {
            guard let stringUrl = sympson.image,
                  let imageURL = URL(string: stringUrl),
                  let imageData = try? Data(contentsOf: imageURL) else {
                return
            }

            DispatchQueue.main.async {
                self.simpsonImage.image = UIImage(data: imageData)
            }
        }

    }
}
