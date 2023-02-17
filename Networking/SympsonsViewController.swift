//
//  SympsonsViewController.swift
//  Networking
//
//  Created by Artur on 14.02.2023.
//

import UIKit

class SympsonsViewController: UITableViewController {

    lazy var buttonNext: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setTitle("NEXT", for: .normal)
        button.addTarget(self, action: #selector(fetchSympsons), for: .touchUpInside)
        
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        
        return indicator
    }()
    
    var sympsons: [Sympson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SympsonsCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 300
        initView()
    }
    
    private func initView() {
        tableView.addSubview(buttonNext)
        tableView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            buttonNext.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            buttonNext.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 600),
            buttonNext.heightAnchor.constraint(equalToConstant: 40),
            buttonNext.widthAnchor.constraint(equalToConstant: 150),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sympsons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SympsonsCell
        let sympson = sympsons[indexPath.row]
        cell.configure(with: sympson)

        return cell
    }

}

    //MARK: - Networking
extension SympsonsViewController {
    @objc func fetchSympsons() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        guard let url = URL(string: URLExamples.exampleSimpsons.rawValue) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            do {
                self.sympsons = try JSONDecoder().decode(Sympsons.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
