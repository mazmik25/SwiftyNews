//
//  Utils.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/24/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import Foundation

struct Base {
    static let newsUrl = "https://newsapi.org/v2/"
    static let newsToken = "YOUR_API_KEY"
    static let categories = ["business", "entertainment", "health", "science", "sports", "technology"]
}

struct NewsParameter {
    static let q = "q"
    static let country = "country"
    static let token = "apiKey"
    static let pageSize = "pageSize"
}
