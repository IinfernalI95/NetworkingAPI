//
//  ViewController.swift
//  Networking
//
//  Created by Artur on 07.02.2023.
//

import SwiftUI

enum URLExamples: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    case exampleSimpsons = "https://thesimpsonsquoteapi.glitch.me/quotes"
    case exampleFive = "https://swiftbook.ru//wp-content/uploads/api/api_courses_capital"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    case imageUrl = "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"
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
    case ourCoursesV2 = "Our Courses II"
    case postRequestWithDict = "POST Request with Dict"
    case postRequestWithModel = "POST Request with Model"
    case alamofireGet = "Alamofire GET"
    case alamofirePost = "Alamofire POST"
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
            let swiftUIController = UIHostingController(rootView: CourseDetailsViewController(viewModel: CourseDetailsViewModel(course: NetworkManager.shared.getCourseV3())))
                presentVC(titleName: "Image VC", viewController: swiftUIController)
            case .exampleOne:
                exampleOneButtonPressed()
            case .exampleTwo:
                exampleTwoButtonPressed()
            case .exampleThree:
                exampleThreeButtonPressed()
            case .exampleFour:
                exampleFourButtonPressed()
            case .exampleSimpsons:
                let sympsonVC = SympsonsViewController()
                sympsonVC.fetchSympsons()
                presentVC(titleName: "Sympsons VC", viewController: sympsonVC)
            case .ourCourses:
                let coursesVC = CoursesViewController()
                coursesVC.fetchCourses()
                presentVC(titleName: "Courses VC", viewController: coursesVC)
            case .weather:
                presentVC(titleName: "Weather VC", viewController: WeatherViewController())
            case .ourCoursesV2:
                presentVC(titleName: "Our Courses 2", viewController: CoursesViewController())
            case .postRequestWithDict:
                postRequestWithDict()
            case .postRequestWithModel:
                postRequestWithModel()
            case .alamofireGet:
                let coursesVC = CoursesViewController()
                coursesVC.alamofireGetButtonPressed()
                presentVC(titleName: "GET", viewController: coursesVC)
            case .alamofirePost:
                let coursesVC = CoursesViewController()
                coursesVC.alamofirePostButtonPressed()
                presentVC(titleName: "POST", viewController: coursesVC)
        }
    }
    
    private func presentVC(titleName: String, viewController: UIViewController) {
        if let vc = viewController as? CoursesViewController {
            vc.fetchCourses()
        }
        //Collection VC
        viewController.title = titleName
        viewController.navigationItem.largeTitleDisplayMode = .always

        //Presenting VC
        show(viewController, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItems()
        collectionViewInit()
    }
    
    private func setUpNavigationItems() {
        navigationItem.backButtonTitle = "Collection"
        navigationItem.title = "Main Collection"
    }
    
    private func collectionViewInit() {
        collectionView?.backgroundColor = .systemGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView!.register(UserActionCell.self, forCellWithReuseIdentifier: "cell")
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
        DispatchQueue.main.async {
            do {
                NetworkManager.shared.exampleOneButtonPressed()
                    self.successAlert()
            } catch {
                self.failedAlert()
            }
        }
        
//        guard let url = URL(string: URLExamples.exampleOne.rawValue) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let data = data else { return }
//            do {
//                let course = try JSONDecoder().decode(Course.self, from: data)
//                print(course)
//                DispatchQueue.main.async {
//                    self.successAlert()
//                }
//            } catch let error {
//                print(error)
//                DispatchQueue.main.async {
//                    self.failedAlert()
//                }
//            }
//        }.resume()
    }

    private func exampleTwoButtonPressed() {
        
        DispatchQueue.main.async {
            do {
                NetworkManager.shared.exampleTwoButtonPressed()
                    self.successAlert()
            } catch {
                self.failedAlert()
            }
        }
    }

    private func exampleThreeButtonPressed() {
        DispatchQueue.main.async {
            do {
                NetworkManager.shared.exampleThreeButtonPressed()
                    self.successAlert()
            } catch {
                self.failedAlert()
            }
        }
    }

    private func exampleFourButtonPressed() {
        DispatchQueue.main.async {
            do {
                NetworkManager.shared.exampleFourButtonPressed()
                    self.successAlert()
            } catch {
                self.failedAlert()
            }
        }
    }
    
    private func postRequestWithDict() {
        DispatchQueue.main.async {
            do {
                NetworkManager.shared.postRequestWithDict()
                    self.successAlert()
            } catch {
                self.failedAlert()
            }
        }
    }
        
    private func postRequestWithModel() {
        DispatchQueue.main.async {
            do {
                NetworkManager.shared.postRequestWithModel()
                    self.successAlert()
            } catch {
                self.failedAlert()
            }
        }
    }
}


extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 80)
    }
}

