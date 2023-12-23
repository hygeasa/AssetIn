//
//  ReportViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

struct ChecklistInventory {
    var name: String
    var isSelected: Bool = false
}

class ReportViewModel: ObservableObject {
    
    @Published var date = Date()
    
    @Published var categories: [ChecklistInventory] = [
        .init(name: "Music"), .init(name: "Sports"), .init(name: "Library"), .init(name: "Laboratory"), .init(name: "Classroom"), .init(name: "Furniture"),
    ]
    
    var filter: [String] {
        return categories.filter({
            $0.isSelected
        }).compactMap({
            $0.name.uppercased()
        })
    }
}
