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

enum CategoryType: Int, Codable, Identifiable, CaseIterable {
    var id: Int { self.rawValue }
    
    case furniture = 1
    case music = 2
    case classroom = 3
    case laboratory = 4
    case sports = 5
    case library = 6
}

extension CategoryType {
    var image: Image {
        switch self {
        case .furniture: .furniture
        case .music: .music
        case .classroom: .classroom
        case .laboratory: .lab
        case .sports: .sports
        case .library: .library
        }
    }
    
    var name: String {
        switch self {
        case .furniture: "Furniture"
        case .music: "Music"
        case .classroom: "Classroom"
        case .laboratory: "Laboratory"
        case .sports: "Sports"
        case .library: "Library"
        }
    }
}
