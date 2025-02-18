//
//  Inventory.swift
//  AssetIn
//
//  Created by Hygea Saveria on 14/12/23.
//

import Foundation

struct Inventory: Codable, Identifiable {
    var id: Int?
    var name: String?
    var categoryId: CategoryType?
    var category: Category?
    var photo: String?
    var quantity: Int?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, category, photo
        case categoryId = "category_id"
        case quantity = "quantity_available"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct InventoryRequest: Codable {
    var name: String?
    var categoryId: CategoryType?
    var photo: String?
    var quantityAvailable: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, photo
        case categoryId = "category_id"
        case quantityAvailable = "quantity_available"
    }
}
