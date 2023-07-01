//
//  ViewController.swift
//  Networking
//
//  Created by Artur on 07.02.2023.
//

import SwiftUI



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
            let swiftUIController = UIHostingController(rootView: CourseDetailsViewController(viewModel: CourseDetailsViewModel(course: NetworkManager.shared.getCourse())))
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
                //coursesVC.fetchCourses() 🔴
                presentVC(titleName: "New Courses VC", viewController: coursesVC)
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
                //coursesVC.alamofireGetButtonPressed()
                presentVC(titleName: "GET", viewController: coursesVC)
            case .alamofirePost:
                let coursesVC = CoursesViewController()
                //coursesVC.alamofirePostButtonPressed()
                presentVC(titleName: "POST", viewController: coursesVC)
        }
    }
    
    private func presentVC(titleName: String, viewController: UIViewController) {
        if let vc = viewController as? CoursesViewController {
            //vc.fetchCourses()🔴
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
        NetworkManager.shared.exampleOneButtonPressed() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successAlert()
                case .failure:
                    self.failedAlert()
                }
            }
        }
    }

    private func exampleTwoButtonPressed() {
        NetworkManager.shared.exampleTwoButtonPressed() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successAlert()
                case .failure:
                    self.failedAlert()
                }
            }
        }
    }

    private func exampleThreeButtonPressed() {
        NetworkManager.shared.exampleThreeButtonPressed() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successAlert()
                case .failure:
                    self.failedAlert()
                }
            }
        }
    }
    
    private func exampleFourButtonPressed() {
        NetworkManager.shared.exampleFourButtonPressed() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successAlert()
                case .failure:
                    self.failedAlert()
                }
            }
        }
    }
    
    private func postRequestWithDict() {
        NetworkManager.shared.postRequestWithDict() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successAlert()
                case .failure:
                    self.failedAlert()
                }
            }
        }
    }
    
    private func postRequestWithModel() {
        NetworkManager.shared.postRequestWithModel() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successAlert()
                case .failure:
                    self.failedAlert()
                }
            }
        }
    }
}


extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 80)
    }
}

