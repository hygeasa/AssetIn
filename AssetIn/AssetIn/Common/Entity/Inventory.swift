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
    var categoryId: String
    var namaInventaris: String
    var stock: Int
    var gambar: String
    
    enum CodingKeys: String, CodingKey {
        case id, category, stock, gambar
        case namaInventaris = "nama_inventaris"
        case categoryId = "category_id"
    }
}

enum CategoryType: String {
    case furniture = "FURNITURE"
    case music = "MUSIC"
    case classroom = "CLASSROOM"
    case laboratory = "LABORATORY"
    case sports = "SPORTS"
    case library = "LIBRARY"
}
