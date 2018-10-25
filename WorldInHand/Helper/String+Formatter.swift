//
//  String+Formatter.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/25/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        if #available(iOS 11.0, *) {
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        } else {
            // Fallback on earlier versions
        }
        return formatter
    }()
}

extension String {
    static func formatDate(fromString string: String) -> String {
        print(string)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: string)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date ?? Date())
        let finalDate = calendar.date(from: components)
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        return dateFormatter.string(from: finalDate!)
    }
}
