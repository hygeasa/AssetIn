//
//  News.swift
//  AssetIn
//
//  Created by Hygea Saveria on 20/12/23.
//

import Foundation

struct News: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var thumbnail: String?
    var title: String?
    var url: String?
}
