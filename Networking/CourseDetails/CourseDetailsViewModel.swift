//
//  ContentViewModel.swift
//  Networking
//
//  Created by Artur on 28.06.2023.
//

import Foundation

protocol CourseDetailsViewModelProtocol {
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numberOfTests: String { get }
    var imageData: Data? { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((CourseDetailsViewModelProtocol) -> Void)? { get set }
    init(course: CourseV3)
    func favoriteButtonPressed()
}

class CourseDetailsViewModel: CourseDetailsViewModelProtocol {
    
    private let course: CourseV3
    
    var courseName: String {
        course.name
    }
    
    var numberOfLessons: String {
        "Number of lessons \(course.numberOfLessons)"
    }
    
    var numberOfTests: String {
        "Number of tests: \(course.numberOfTests)"
    }
    
    var imageData: Data? { //🔴 не оч понятно
        ImageManager.shared.fetchImageData(from: URL(string: course.imageUrl))
    }
    
    var isFavorite: Bool { //🔴 не оч понятно
        get {
            DataManager.shared.getFavoriteStatus(for: course.name)
        } set {
            DataManager.shared.setFavoriteStatus(for: course.name, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((CourseDetailsViewModelProtocol) -> Void)?
    
    required init(course: CourseV3) {
        self.course = course
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
}
