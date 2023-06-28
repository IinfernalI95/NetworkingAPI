//
//  ImageViewController.swift
//  Networking
//
//  Created by Artur on 10.02.2023.
//

//import UIKit
//
//class ImageViewController: UIViewController {
//    
//    var imageView: UIImageView = {
//        let image = UIImageView()
//        image.backgroundColor = .white
//        image.translatesAutoresizingMaskIntoConstraints = false
//        
//        return image
//    }()
//    
//    var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView()
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.transform = CGAffineTransform(scaleX: 3, y: 3)
//        
//        return indicator
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        initView()
//        activityIndicator.startAnimating()
//        activityIndicator.hidesWhenStopped = true
//        fetchImage()
//    }
//    
//    private func initView() {
//        view.addSubview(imageView)
//        view.addSubview(activityIndicator)
//        
//        NSLayoutConstraint.activate([
//            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height),
//            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    private func fetchImage() {
//        guard let url = URL(string: URLExamples.imageURL.rawValue) else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            if let response = response {
//                print(response)
//            }
//            
//            if let data = data, let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                    self.activityIndicator.stopAnimating()
//                }
//            }
//        }.resume()
//    }
//}
