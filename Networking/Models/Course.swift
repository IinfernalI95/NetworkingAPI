//
//  Course.swift
//  Networking
//
//  Created by Artur on 11.02.2023.
//

import Foundation

struct Course: Codable {
    let name: String?
    let imageUrl: URL?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    init(courseData: [String: Any]) {
        name = courseData["name"] as? String
        imageUrl = courseData["imageUrl"] as? URL
        numberOfLessons = courseData["number_of_lessons"] as? Int
        numberOfTests = courseData["number_of_tests"] as? Int
    }
    
    static func getCourse(from value: Any) -> [Course] {
        guard let coursesData = value as? [[String: Any]] else { return []}
        
        var courses: [Course] = []
        for courseData in coursesData {
            let course = Course(courseData: courseData)
            courses.append(course)
        }
        return coursesData.compactMap { Course(courseData: $0) }
    }
    
//    static func fromCourceToV3(course: Course) -> CourseV3? {
//        CourseV3(name: course.name ?? "Error",
//                 imageUrl: course.imageUrl?.absoluteString ?? "Error",
//                 numberOfLessons: String(course.numberOfLessons!) ?? "0",
//                 numberOfTests: String(course.numberOfTests!) ?? "0")
//    }
}

struct WebsiteDescription: Codable {
    let courses: [Course]
    let websiteDescription: String
    let websiteName: String
}

struct CourseV3: Codable {
    let name: String
    let imageUrl: String
    let numberOfLessons: String
    let numberOfTests: String
}
