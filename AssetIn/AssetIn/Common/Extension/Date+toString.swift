//
//  Date+toString.swift
//  AssetIn
//
//  Created by Hygea Saveria on 20/12/23.
//

import Foundation

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

enum DateFormat: String {
    case withSlash = "dd/MM/yyyy"
}
