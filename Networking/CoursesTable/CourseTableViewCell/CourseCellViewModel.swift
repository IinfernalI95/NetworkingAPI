//
//  CourseTableViewCellViewModel.swift
//  Networking
//
//  Created by Artur on 28.06.2023.
//

import Foundation

protocol CourseCellViewModelProtocol: AnyObject {
    var courseName: String { get }
    var numberOfTests: String { get }
    var numberOfLessons: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

class CourseCellViewModel: CourseCellViewModelProtocol {
    
    private let course: Course
    
    var courseName: String {
        guard let name = course.name else { return "error in CourseCellViewModel -> course.name" }
        return name
    }
    
    var numberOfTests: String {
        guard let numberOfTests = course.numberOfTests else { return "error in CourseCellViewModel -> course.numberOfTests" }
        return "Number of tests: \(numberOfTests)"
    }
    
    var numberOfLessons: String {
        guard let numberOfLessons = course.numberOfLessons else { return "error in CourseCellViewModel -> course.numberOfLessons" }
        return "Number of lessons \(numberOfLessons)"
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: course.imageUrl)
    }
    
    required init(course: Course) {
        self.course = course
    }
    
    
}
