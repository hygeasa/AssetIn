//
//  Loan.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation

struct Loan: Codable, Identifiable {
    var id: Int?
    var inventoryId: Int?
    var inventory: Inventory?
    var userId: Int?
    var user: User?
    var quantity: Int?
    var status: LoanStatus?
    var dueDate: String?
    var createdAt: String?
    var updatedAt: String?
    var pickupLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case id, inventory, user, quantity, status
        case inventoryId = "inventory_id"
        case userId = "user_id"
        case dueDate = "due_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pickupLocation = "pickup_location"
    }
}

enum LoanStatus: String, Codable, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case request = "REQUEST"
    case ready = "READY"
    case onGoing = "ON-GOING"
    case done = "DONE"
}

struct LoanRequest: Codable {
    var inventoryId: Int
    var userId: Int
    var quantity: Int
    var status = "REQUEST"
    var dueDate: Date
    
    enum CodingKeys: String, CodingKey {
        case quantity, status
        case inventoryId = "inventory_id"
        case userId = "user_id"
        case dueDate = "due_date"
    }
}
