//
//  String+dateDisplay.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import Foundation

extension String {
    func dateDisplay(_ style: DateDisplayStyle) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = style.rawValue
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}

enum DateDisplayStyle: String {
    case slash = "d/M/yyyy 'at' HH:mm"
    case full = "EEE, dd MMM yyyy 'at' HH:mm"
}
