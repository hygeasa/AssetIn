//
//  EditDataViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 13/12/23.
//

import SwiftUI

class EditDataViewModel : ObservableObject {
    @Published var category = "Music Equipment"
    @Published var item = "5"
    
    @Published var data: [InventoryType] = [
        .init(title: "Music Equipment", items: [
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5)
        ]),
        .init(title: "Gea's Equipment", items: [
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5)
        ]),
        .init(title: "Iam's Equipment", items: [
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5)
        ]),
        .init(title: "Music Equipment", items: [
            .init(name: "Piano", stock: 5)
        ]),
        .init(title: "Music Equipment", items: [
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5),
            .init(name: "Piano", stock: 5)
        ]),
    ]
}
