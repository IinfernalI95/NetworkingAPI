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
    init(course: Course)
    func favoriteButtonPressed()
    func fetchImageData()
}

class CourseDetailsViewModel: CourseDetailsViewModelProtocol {
    
    private let course: Course
    
    var courseName: String {
        guard let name = course.name else { return "" }
        return name
    }
    
    var numberOfLessons: String {
        guard let numberOfLessons = course.numberOfLessons else { return "Number of lessons - no data" }
        return "Number of lessons \(numberOfLessons)"
    }
    
    var numberOfTests: String {
        guard let numberOfTests = course.numberOfTests else { return "Number of tests: - no data" }
        return "Number of tests: \(numberOfTests)"
    }
    
    var imageData: Data? 
    
    var isFavorite: Bool { //🔴 не оч понятно
        get {
            DataManager.shared.getFavoriteStatus(for: course.name!)
        } set {
            DataManager.shared.setFavoriteStatus(for: course.name!, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((CourseDetailsViewModelProtocol) -> Void)?
    
    required init(course: Course) {
        self.course = course
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
    
    func fetchImageData() {
        guard let url = course.imageUrl else {
            print("Error: Image URL is nil")
            return
        }
        
        ImageManager.shared.fetchImageData(from: url) { data in
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
    }
}
