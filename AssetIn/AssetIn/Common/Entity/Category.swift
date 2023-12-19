//
//  Category.swift
//  AssetIn
//
//  Created by Hygea Saveria on 19/12/23.
//

import SwiftUI

struct Category: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var image: Image
}
