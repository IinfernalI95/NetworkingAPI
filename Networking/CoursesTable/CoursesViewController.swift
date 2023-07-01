//
//  CoursesViewController.swift
//  Networking
//
//  Created by Artur on 10.02.2023.
//

import SwiftUI

class CoursesViewController: UITableViewController {
    
    private var viewModel: CourseViewModelProtocol! {
        didSet {
            viewModel.fetchCourses { [weak self] in
                self?.tableView.reloadData() //🔴 скорее всего нужно сделать слабую ссылку
            }
            
//            viewModel.alamofireGetButtonPressed { [weak self] in
//                self?.tableView.reloadData()
//            }
//
//            viewModel.alamofirePostButtonPressed { [weak self] in
//                self?.tableView.reloadData()
//            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CourseCellView.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 100
        viewModel = CourseViewModel()
    }

    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCellView
        cell.viewModel = viewModel.cellViewModel(index: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let course = viewModel.courses[indexPath.row]
        //guard let courseV3 = Course.fromCourceToV3(course: course) else { return }
        let swiftUIController = UIHostingController(rootView: viewModel.viewModelForSelectedRow(index: indexPath))
        
        //Collection VC
        swiftUIController.title = viewModel.viewModelSelectedNameForTitle(index: indexPath) //🔴 не уверен что так можно
        swiftUIController.navigationItem.largeTitleDisplayMode = .always

        //Presenting VC
        show(swiftUIController, sender: nil)
    }
}

