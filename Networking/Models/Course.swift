//
//  Course.swift
//  Networking
//
//  Created by Artur on 11.02.2023.
//

import Foundation

struct Course: Codable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: String?
    let numberOfTests: String?
    
    init(courseData: [String: Any]) {
        name = courseData["name"] as? String
        imageUrl = courseData["imageUrl"] as? String
        numberOfLessons = courseData["number_of_lessons"] as? String
        numberOfTests = courseData["number_of_tests"] as? String
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
    
    static func fromCourceToV3(course: Course) -> CourseV3? {
        CourseV3(name: course.name ?? "Error",
                 imageUrl: course.imageUrl ?? "Error",
                 numberOfLessons: course.numberOfLessons ?? "0",
                 numberOfTests: course.numberOfTests ?? "0")
    }
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
