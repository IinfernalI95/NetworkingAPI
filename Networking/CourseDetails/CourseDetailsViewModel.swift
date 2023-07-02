//
//  CourseDetailsViewModel2.swift
//  Networking
//
//  Created by Artur on 01.07.2023.
//

import Foundation

class CourseDetailsViewModel: ObservableObject {
    let repository: ImageManager = ImageManager.shared
    private let course: Course
    
    init(course: Course) {
        self.course = course
        self.isFavorite = DataManager.shared.getFavoriteStatus(for: self.course.name!)
    }
    
    @Published
    var imageData: Data?
    
    @Published
    var isFavorite: Bool = false {
        didSet {
            DataManager.shared.setFavoriteStatus(for: course.name!, with: isFavorite)
        }
    }
    
    var courseName: String {
        guard let name = course.name else { return "courseName - no data" }
        return name
    }
    
    var numberOfLessons: String {
        guard let numberOfLessons = course.numberOfLessons else { return "Number of lessons - no data" }
        return "Number of lessons: \(numberOfLessons)"
    }
    
    var numberOfTests: String {
        guard let numberOfTests = course.numberOfTests else { return "Number of tests: - no data" }
        return "Number of tests: \(numberOfTests)"
    }
    
    @MainActor //тот же Dispatch.main.async только для SwiftUI
    func getImageData() async {
        guard let url = course.imageUrl else { return }
        imageData = try? await repository.downloadImage(fromURL: url)
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
}
