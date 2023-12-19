//
//  SearchViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    
    @Published var searchText = ""
    
    var isAdmin: Bool {
        loginStatus == 2
    }
    
    @Published var categories: [Category] = [
        .init(id: CategoryType.furniture.rawValue, name: CategoryType.furniture.rawValue.capitalized, image: .furniture),
        .init(id: CategoryType.music.rawValue, name: CategoryType.music.rawValue.capitalized, image: .music),
        .init(id: CategoryType.classroom.rawValue, name: CategoryType.classroom.rawValue.capitalized, image: .classroom),
        .init(id: CategoryType.laboratory.rawValue, name: CategoryType.laboratory.rawValue.capitalized, image: .lab),
        .init(id: CategoryType.sports.rawValue, name: CategoryType.sports.rawValue.capitalized, image: .sports),
        .init(id: CategoryType.library.rawValue, name: CategoryType.library.rawValue.capitalized, image: .library),
    ]
    
    var searchedCategories: [Category] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { category in
                category.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
