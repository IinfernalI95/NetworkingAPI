//
//  CourseCell.swift
//  Networking
//
//  Created by Artur on 10.02.2023.
//

import UIKit

class CourseCellView: UITableViewCell {
    
    var courseImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var courseNameLabel: UILabel = {
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
    
    var numberOfLessons: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        
        return label
    }()
    
    var numberOfTests: UILabel = {
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
        addSubview(courseImage)
        addSubview(courseNameLabel)
        addSubview(numberOfLessons)
        addSubview(numberOfTests)
        
        NSLayoutConstraint.activate([
            courseImage.topAnchor.constraint(equalTo: topAnchor),
            courseImage.leftAnchor.constraint(equalTo: leftAnchor),
            courseImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            courseImage.widthAnchor.constraint(equalToConstant: 140),
            courseNameLabel.topAnchor.constraint(equalTo: topAnchor),
            courseNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            courseNameLabel.leftAnchor.constraint(equalTo: courseImage.rightAnchor, constant: 16),
            courseNameLabel.heightAnchor.constraint(equalToConstant: 42),
            numberOfLessons.topAnchor.constraint(equalTo: courseNameLabel.bottomAnchor, constant: 8),
            numberOfLessons.leftAnchor.constraint(equalTo: courseNameLabel.leftAnchor),
            numberOfLessons.widthAnchor.constraint(equalTo: courseNameLabel.widthAnchor),
            numberOfLessons.heightAnchor.constraint(equalToConstant: 16),
            numberOfTests.topAnchor.constraint(equalTo: numberOfLessons.bottomAnchor, constant: 8),
            numberOfTests.leftAnchor.constraint(equalTo: numberOfLessons.leftAnchor),
            numberOfTests.widthAnchor.constraint(equalTo: numberOfLessons.widthAnchor),
            numberOfTests.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    var viewModel: CourseCellViewModelProtocol! {
        didSet {
            courseNameLabel.text = viewModel.courseName
            numberOfTests.text = viewModel.numberOfTests
            numberOfLessons.text = viewModel.numberOfLessons
            
            DispatchQueue.main.async { [unowned self] in
                guard let imageData = viewModel.imageData else { return }
                courseImage.image = UIImage(data: imageData)
            }
        }
    }
}
