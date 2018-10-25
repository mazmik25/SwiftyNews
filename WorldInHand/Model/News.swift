//
//  News.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/24/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let name = "name"
    static let source = "source"
    static let id = "id"
    static let author = "author"
    static let title = "title"
    static let description = "description"
    static let url = "url"
    static let urlToImage = "urlToImage"
    static let publishedAt = "publishedAt"
    static let content = "content"
}

struct News {
    var name: String = ""
    var source: String = ""
    var id: String = ""
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    
    init() {
        
    }
    
    init(json: JSON?) {
        self.init()
        if let json = json {
            self.name = json[SerializationKey.name].stringValue
            self.source = json[SerializationKey.source][SerializationKey.name].stringValue
            self.id = json[SerializationKey.source][SerializationKey.id].stringValue
            self.author = json[SerializationKey.author].stringValue
            self.title = json[SerializationKey.title].stringValue
            self.description = json[SerializationKey.description].stringValue
            self.url = json[SerializationKey.url].stringValue
            self.urlToImage = json[SerializationKey.urlToImage].stringValue
            self.publishedAt = json[SerializationKey.publishedAt].stringValue
            self.content = json[SerializationKey.content].stringValue
        }
    }
}
