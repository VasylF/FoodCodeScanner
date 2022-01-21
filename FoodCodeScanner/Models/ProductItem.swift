//
//  ProductItem.swift
//  FoodCodeScanner
//
//  Created by Vasyl Fuchenko on 6/6/20.
//  Copyright © 2020 Vasyl Fuchenko. All rights reserved.
//

import Foundation

struct ProductItem: Codable {
    var linkk: String?
    var snippet: String?
    
}


struct PageMapp: Codable {
    var offer: [Offer]
}

struct Offer: Codable {
    var pricecurrency: String?
    var price: String?
}
