//
//  ViewController.swift
//  Networking
//
//  Created by Artur on 07.02.2023.
//

import UIKit

enum URLExamples: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    case exampleSimpsons = "https://thesimpsonsquoteapi.glitch.me/quotes"
}

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One - need VPN"
    case exampleTwo = "Example Two - need VPN"
    case exampleThree = "Example Three - need VPN"
    case exampleFour = "Example Four - need VPN"
    case ourCourses = "Our Courses - need VPN"
    case exampleSimpsons = "Simpsons"
    case weather = "Weather"
}

class MainCollectionViewController: UICollectionViewController {

    let userActions = UserActions.allCases
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        print(userAction)
        
        switch userAction {
            case .downloadImage:
                //Collection VC
                let imageVC = ImageViewController()
                imageVC.title = "Image VC"
                imageVC.navigationItem.largeTitleDisplayMode = .always
            
                //Presenting VC
                show(imageVC, sender: nil)
            case .exampleOne:
                exampleOneButtonPressed()
            case .exampleTwo:
                exampleTwoButtonPressed()
            case .exampleThree:
                exampleThreeButtonPressed()
            case .exampleFour:
                exampleFourButtonPressed()
            case .exampleSimpsons:
                //exampleSimpsonsButtonPressed()
                //Collection VC
                let sympsonVC = SympsonsViewController()
                sympsonVC.title = "Sympsons VC"
                sympsonVC.navigationItem.largeTitleDisplayMode = .always
                sympsonVC.fetchSympsons()
            
                //Presenting VC
                show(sympsonVC, sender: nil)
            case .ourCourses:
                //Collection VC
                let coursesVC = CoursesViewController()
                coursesVC.title = "Courses VC"
                coursesVC.navigationItem.largeTitleDisplayMode = .always
                coursesVC.fetchCourses()
            
                //Presenting VC
                show(coursesVC, sender: nil)
            case .weather:
                //Collection VC
                let weatherVC = WeatherViewController()
                weatherVC.title = "Weather VC"
                weatherVC.navigationItem.largeTitleDisplayMode = .always
            
                //Presenting VC
                show(weatherVC, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .systemGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView!.register(UserActionCell.self, forCellWithReuseIdentifier: "cell")
        navigationItem.backButtonTitle = "Collection"
        navigationItem.title = "Main Collection"
    }

//    // MARK: - Private Methods
    private func successAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "You can see the results in the Debug aria",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    private func failedAlert() {
        let alert = UIAlertController(title: "Failed",
                                      message: "You can see error in the Debug aria",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension MainCollectionViewController {
    private func exampleOneButtonPressed() {
        guard let url = URL(string: URLExamples.exampleOne.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }

    private func exampleTwoButtonPressed() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }

    private func exampleThreeButtonPressed() {
        guard let url = URL(string: URLExamples.exampleThree.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }

    private func exampleFourButtonPressed() {
        guard let url = URL(string: URLExamples.exampleFour.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleSimpsonsButtonPressed() {
        guard let url = URL(string: URLExamples.exampleSimpsons.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let simpsons = try JSONDecoder().decode(Sympsons.self, from: data)
                print(data)
                print(simpsons)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 80)
    }
}

