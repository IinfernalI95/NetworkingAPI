//
//  NetworkManager.swift
//  Networking
//
//  Created by Artur on 27.06.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func exampleOneButtonPressed() {
        guard let url = URL(string: URLExamples.exampleOne.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func exampleTwoButtonPressed() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func exampleThreeButtonPressed() {
        guard let url = URL(string: URLExamples.exampleThree.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(course)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func exampleFourButtonPressed() {
        guard let url = URL(string: URLExamples.exampleFour.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(course)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func postRequestWithDict() {
        guard let url = URL(string: URLExamples.postRequest.rawValue) else { return }                               // ⬇️
        let course = ["name": "Test",
                      "imageUrl": URLExamples.imageURL.rawValue,
                      "numberOfLessons": "10",
                      "numberOfTests": "1"]
        guard let courseData = try? JSONSerialization.data(withJSONObject: course, options: []) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = courseData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response, let data = data else { return }

            print(response)

            do {
                let course = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    print("DESERIALIZE ->")
                    print(course)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func postRequestWithModel() {
        guard let url = URL(string: URLExamples.postRequest.rawValue) else { return }
        let course = CourseV3(name: "Test",
                              imageUrl: URLExamples.imageURL.rawValue,
                              numberOfLessons: "10",
                              numberOfTests: "1")
        guard let courseData = try? JSONEncoder().encode(course) else { return }
        var request = URLRequest(url: url)  //создаем запрос серверу
        request.httpMethod = "POST"         //метод который будет использоваться в запросе
        request.httpBody = courseData       //что мы будем передавать в запросе

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response, let data = data else { return }

            print("ОТВЕТ ОТ СЕРВЕРА -> \(response)") //ответ от сервера

            do {
                let course = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    print("DESERIALIZE ->")
                    print(course)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getCourseV3() -> CourseV3 {
        CourseV3(name: "Course Name",
                 imageUrl: "https://swiftbook.ru/wp-content/uploads/2018/03/2-courselogo.jpg",
                 numberOfLessons: "10",
                 numberOfTests: "1")
    }
    
    //надо как то реализовать во избежание ошибки асинхронности 🔴
//    func getCourseV3(completion: @escaping (CourseV3) -> Void) {
//        DispatchQueue.main.async {
//            let course = CourseV3(name: "Course Name",
//                                  imageUrl: "https://swiftbook.ru/wp-content/uploads/2018/03/2-courselogo.jpg",
//                                  numberOfLessons: "10",
//                                  numberOfTests: "1")
//            completion(course)
//        }
//    }
}
