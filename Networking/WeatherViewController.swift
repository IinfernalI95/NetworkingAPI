//
//  WeatherViewController.swift
//  Networking
//
//  Created by Artur on 14.02.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var backgroundView: UIImageView = {
        let image = UIImage(imageLiteralResourceName: "backgroundWeather")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var weatherIconImageView: UIImageView = {
        //let largeFont = UIFont.systemFont(ofSize: 60)
        //let configuration = UIImage.SymbolConfiguration(font: largeFont) // <1>
        let image = UIImage(systemName: "cloud.rain.fill")
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(named: "testColor") // <2>
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "25"
        label.textAlignment = .center
        label.font = label.font.withSize(70)
        label.textColor = UIColor(named: "testColor")
        
        return label
    }()
    
    var celsiusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°C"
        label.textColor = UIColor(named: "testColor")
        label.textAlignment = .center
        label.font = label.font.withSize(70)
        
        return label
    }()
    
    var feelsLikeStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.text = "Feels like "
        label.textColor = UIColor(named: "testColor")
        label.textAlignment = .right
        
        return label
    }()
    
    var feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 23 °C"
        label.textColor = UIColor(named: "testColor")
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ufa"
        label.textColor = UIColor(named: "testColor")
        label.font = label.font.withSize(28)
        
        return label
    }()
    
    lazy var buttonSearch: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "magnifyingglass.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "testColor")
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        
        return button
    }()
    
    let networkWeatherManager = NetworkWeatherManager()
    
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        initView()
        networkWeatherManager.fetchCurrentWeather(forSity: "London")
    }
    
    private func initView() {
        view.addSubview(backgroundView)
        view.addSubview(weatherIconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(celsiusLabel)
        view.addSubview(feelsLikeTemperatureLabel)
        view.addSubview(feelsLikeStaticLabel)
        view.addSubview(cityLabel)
        view.addSubview(buttonSearch)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            weatherIconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            weatherIconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            weatherIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            weatherIconImageView.heightAnchor.constraint(equalTo: weatherIconImageView.widthAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 0),
            temperatureLabel.leftAnchor.constraint(equalTo: weatherIconImageView.leftAnchor, constant: 0),
            temperatureLabel.heightAnchor.constraint(equalTo: temperatureLabel.widthAnchor),
            celsiusLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor),
            celsiusLabel.rightAnchor.constraint(equalTo: weatherIconImageView.rightAnchor),
            celsiusLabel.heightAnchor.constraint(equalTo: celsiusLabel.widthAnchor),
            feelsLikeStaticLabel.leftAnchor.constraint(equalTo: weatherIconImageView.leftAnchor),
            feelsLikeStaticLabel.topAnchor.constraint(equalTo: celsiusLabel.bottomAnchor, constant: 0),
            feelsLikeStaticLabel.widthAnchor.constraint(equalToConstant: 140),
            feelsLikeStaticLabel.heightAnchor.constraint(equalToConstant: 20),
            feelsLikeTemperatureLabel.topAnchor.constraint(equalTo: feelsLikeStaticLabel.topAnchor, constant: 0),
            feelsLikeTemperatureLabel.rightAnchor.constraint(equalTo: celsiusLabel.rightAnchor),
            feelsLikeTemperatureLabel.leftAnchor.constraint(equalTo: feelsLikeStaticLabel.rightAnchor, constant: 0),
            feelsLikeTemperatureLabel.heightAnchor.constraint(equalTo: feelsLikeStaticLabel.heightAnchor),
            cityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            cityLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            cityLabel.heightAnchor.constraint(equalToConstant: 32),
            cityLabel.widthAnchor.constraint(equalToConstant: 44),
            buttonSearch.leftAnchor.constraint(equalTo: cityLabel.rightAnchor),
            buttonSearch.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: 0),
            buttonSearch.heightAnchor.constraint(equalTo: cityLabel.heightAnchor),
            buttonSearch.widthAnchor.constraint(equalTo: buttonSearch.heightAnchor),
        ])

        //temperatureLabel.layoutIfNeeded()
        view.layoutIfNeeded()

        NSLayoutConstraint.activate([
            temperatureLabel.widthAnchor.constraint(equalToConstant: weatherIconImageView.frame.width / 2),
            celsiusLabel.widthAnchor.constraint(equalToConstant: weatherIconImageView.frame.width / 2)
        ])
    }
}

extension WeatherViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        //создаем Alert Controller ( текст титла , сообщение , стиль )
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        //добавляем к AC текстфилд и сразу же его создаем
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        
        //создаем кнопку поиска с действием по нажатию
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                print("search info for the \(cityName)")
            }
        }
        //кнопка отмены
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //добавляем кнопки и представляем AC
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}

