//
//  Category.swift
//  AssetIn
//
//  Created by Hygea Saveria on 19/12/23.
//

import SwiftUI

struct Category: Codable, Identifiable {
    var id: CategoryType?
    var name: String?
}

extension Category {
    var image: Image {
        switch id {
        case .furniture: .furniture
        case .music: .music
        case .classroom: .classroom
        case .laboratory: .lab
        case .sports: .sports
        default: .library
        }
    }
}

enum CategoryType: Int, Codable, CaseIterable {
    case furniture = 1
    case music = 2
    case classroom = 3
    case laboratory = 4
    case sports = 5
    case library = 6
}
