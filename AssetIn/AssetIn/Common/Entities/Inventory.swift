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
    var createdAt: Date?
    var updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, name, category, photo
        case categoryId = "category_id"
        case quantity = "quantity_available"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
