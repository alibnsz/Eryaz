//
//  Model.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 6.08.2024.
//

import Foundation

struct ModelElement: Codable {
    let title: String
    let description: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL = "imageUrl"
    }
}

typealias Model = [ModelElement]
