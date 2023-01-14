//
//  GetRestaurantDetailEndPoint.swift
//  YelpRBC
//
//  Created by Chandra Sekhar Ravi on 10/01/23.
//

import Foundation


struct GetRestaurantDetailEndPoint: Endpoint {
    var path: String
    typealias DataType = Restaurant
    var queryItems: [URLQueryItem] = []
}
