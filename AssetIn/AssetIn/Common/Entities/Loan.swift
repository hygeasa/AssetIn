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
    var dueDate: Date?
    var createdAt: Date?
    var updatedAt: Date?
    var pickupLocation: String?
}

enum LoanStatus: String, Codable, CaseIterable {
    case request = "REQUEST"
    case ready = "READY"
    case onGoing = "ON-GOING"
    case done = "DONE"
}
