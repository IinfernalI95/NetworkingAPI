//
//  ImageManager.swift
//  Networking
//
//  Created by Artur on 28.06.2023.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from url: URL?) -> Data? {
        guard let url = url else {
            print("error on unwrap url")
            return nil
        }
        guard let imageData = try? Data(contentsOf: url) else {
            print("error on create data") //🔴
            return nil
        }
        return imageData
    }
    
//    func fetchImageData(from url: URL?, completion: @escaping (Data?) -> Void) {
//            guard let url = url else {
//                print("Error: URL is nil")
//                completion(nil)
//                return
//            }
//
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let imageData = data, error == nil else {
//                    print("Error fetching image data: \(error?.localizedDescription ?? "Unknown error")")
//                    completion(nil)
//                    return
//                }
//
//                completion(imageData)
//            }.resume()
    
        func downloadImage(fromURL url: URL) async throws -> Data {
            let (data, _) = try await URLSession.shared.data(from: url)
            
    //        if let imageData = data {
    //            return imageData
    //        } else {
    //            throw DownloadError.invalidImageData
    //        }
            return data //🔴 не нужно ли обрабатывать есть ли дата ?!?!
        }

        enum DownloadError: Error {
            case invalidImageData
        }
//    }
}
