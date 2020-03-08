//
//  RestaurantModel.swift
//  RestaurantsIBM
//
//  Created by DragosRotaru on 28/02/2020.
//  Copyright © 2020 DragosRotaru. All rights reserved.
//

import Foundation


struct RestaurantModel: Codable {
    let id: String
    let name: String
    let description: String
    let imagePaths: [String]
    let latitude: String
    let longitude: String
    let rating: Double
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description = "descr"
        case imagePaths
        case latitude
        case longitude
        case rating
        case tags
    }
}
