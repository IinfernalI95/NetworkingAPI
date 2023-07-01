//
//  CoursesViewModel.swift
//  Networking
//
//  Created by Artur on 27.06.2023.
//

import Foundation

protocol CourseViewModelProtocol: AnyObject {
    var courses: [Course] { get }
    func fetchCourses(completion: @escaping() -> Void)
    func alamofireGetButtonPressed(completion: @escaping() -> Void)
    func alamofirePostButtonPressed(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(index: IndexPath) -> CourseCellViewModelProtocol
    func viewModelForSelectedRow(index: IndexPath) -> CourseDetailsViewController
    func viewModelSelectedNameForTitle(index: IndexPath) -> String
}

class CourseViewModel: CourseViewModelProtocol {
    
    var courses: [Course] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] courses in
            self.courses = courses
            completion()
        }
    }
    
    func alamofireGetButtonPressed(completion: @escaping() -> Void) {
        NetworkManager.shared.alamofireGetButtonPressed { courses in
            self.courses = courses
            completion()
        }
    }
    
    func alamofirePostButtonPressed(completion: @escaping() -> Void) {
        NetworkManager.shared.alamofirePostButtonPressed { courses in
            self.courses = courses
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        courses.count
    }
    
    func cellViewModel(index: IndexPath) -> CourseCellViewModelProtocol {
        CourseCellViewModel(course: courses[index.row])
    }
    
    func viewModelForSelectedRow(index: IndexPath) -> CourseDetailsViewController {
        //CourseDetailsViewModel(course: courses[index.row])
        CourseDetailsViewController(viewModel: CourseDetailsViewModel(course: courses[index.row]))
    }
    
    func viewModelSelectedNameForTitle(index: IndexPath) -> String {
        guard let name = courses[index.row].name else { return "error viewModelSelectedNameForTitle" }
        return name
    }
}
