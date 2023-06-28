//
//  Sympsons.swift
//  Networking
//
//  Created by Artur on 14.02.2023.
//

import Foundation

// MARK: - Sympson
struct Sympson: Codable {
    let quote, character: String?
    let image: String?
    let characterDirection: String?
}

typealias Sympsons = [Sympson]
