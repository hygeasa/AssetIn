//
//  User.swift
//  AssetIn
//
//  Created by Hygea Saveria on 19/12/23.
//

import Foundation

struct User: Codable {
    var id: String = UUID().uuidString
    var nama: String
    var nis: String
    var isAdmin: Bool
    var email: String
    var imageURL: String? = nil
}
