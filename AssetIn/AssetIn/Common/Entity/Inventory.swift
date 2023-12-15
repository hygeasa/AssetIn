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

struct Inventaris: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var category: String
    var namaInventaris: String
    var stock: Int
    var gambar: String
    
    enum CodingKeys: String, CodingKey {
        case id, category, stock, gambar
        case namaInventaris = "nama_inventaris"
    }
}
