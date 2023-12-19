//
//  History.swift
//  AssetIn
//
//  Created by Hygea Saveria on 20/12/23.
//

import Foundation

struct History: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var inventoryId: String?
    var studentId: String
    var status: String?
    var stock: Int?
    var borrowedAt: Date?
    var expiredAt: Date?
    var returnedAt: Date?
}

enum HistoryStatus: String {
    case done = "Done"
    case onGoing = "On Going"
    case onProcess = "On Process"
}
