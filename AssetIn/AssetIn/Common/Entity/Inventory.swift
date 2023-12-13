//
//  Inventory.swift
//  AssetIn
//
//  Created by Hygea Saveria on 14/12/23.
//

import Foundation

struct Inventory: Identifiable {
    var id: UUID = .init()
    var name: String
    var stock: Int
}

struct InventoryType: Identifiable {
    var id: UUID = .init()
    var title: String
    var items: [Inventory]
}
