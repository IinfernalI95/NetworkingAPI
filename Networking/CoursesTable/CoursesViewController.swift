//
//  CoursesViewController.swift
//  Networking
//
//  Created by Artur on 10.02.2023.
//

import SwiftUI
import Alamofire

class CoursesViewController: UITableViewController {

    var courses: [Course] = []
    var coursesV3: [CourseV3] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CourseCellView.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 100
    }

    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCellView
        let course = courses[indexPath.row]
        cell.configure(with: course)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        guard let courseV3 = Course.fromCourceToV3(course: course) else { return }
        let swiftUIController = UIHostingController(rootView: CourseDetailsViewController(viewModel: CourseDetailsViewModel(course: courseV3)))
        
        //Collection VC
        swiftUIController.title = course.name
        swiftUIController.navigationItem.largeTitleDisplayMode = .always

        //Presenting VC
        show(swiftUIController, sender: nil)
    }
}

    //MARK: - Networking
extension CoursesViewController {
    func fetchCourses() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            do {
                self.courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}


extension CoursesViewController {
    func alamofireGetButtonPressed() {
        //новый метод responseDecodable использует параметр of: в который нужно вложить тип который будем декодить ?!
        AF.request(URLExamples.exampleTwo.rawValue).validate().responseDecodable(of: [Course].self) { response in
            switch response.result {
            case .success(let courses):
                self.courses = courses
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func alamofirePostButtonPressed() {
        let course = ["name": "Test",
                      "imageUrl": URLExamples.imageURL.rawValue,
                      "numberOfLessons": "10",
                      "numberOfTests": "1"]
        AF.request(URLExamples.postRequest.rawValue, method: .post, parameters: course)
            .validate()
            .responseDecodable(of: Course.self) { dataResponse in
                switch dataResponse.result {
                case .success(let courseData):
                    self.courses.append(courseData)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
