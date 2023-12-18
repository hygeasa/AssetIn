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
    
    @Published var checkList: [ChecklistInventory] = [
        .init(name: "Piano"),
        .init(name: "Gitar"),
        .init(name: "Projector"),
        .init(name: "Table"),
        .init(name: "Chair"),
    ]
    
    @Published var categories: [ChecklistInventory] = [
        .init(name: "Music"), .init(name: "Sports"), .init(name: "Library"), .init(name: "Laboratory"), .init(name: "Classroom"), .init(name: "Furniture"),
    ]
}
