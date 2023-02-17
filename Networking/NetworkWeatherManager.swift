//
//  NetworkWeatherManager.swift
//  Networking
//
//  Created by Artur on 17.02.2023.
//

import Foundation

struct NetworkWeatherManager {
    
    
    func fetchCurrentWeather(forSity sity: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(sity)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
            
        }
        task.resume()
    }
    
}
