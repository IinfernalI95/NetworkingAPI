//
//  CoursesViewModel.swift
//  Networking
//
//  Created by Artur on 27.06.2023.
//

import Foundation

protocol CourseListViewModelProtocol: AnyObject {
    var courses: [Course] { get }
}

class CourseViewModel: CourseListViewModelProtocol {
    var courses: [Course] = []
    
    
}
