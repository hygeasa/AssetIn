//
//  History.swift
//  AssetIn
//
//  Created by Hygea Saveria on 20/12/23.
//

import Foundation
import FirebaseFirestore

struct History: Codable, Identifiable, Hashable {
    var id: String? = UUID().uuidString
    var inventoryId: String?
    var studentId: String?
    var studentName: String?
    var studentNIS: String?
    var categoryId: String?
    var inventoryName: String?
    var status: String?
    var place: String?
    var stock: Int?
    var requestedAt: Date?
    var borrowedAt: Date?
    var expiredAt: Date?
    var returnedAt: Date?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let id {
            try container.encode(id, forKey: .id)
        }
        
        if let inventoryId {
            try container.encode(inventoryId, forKey: .inventoryId)
        }
        
        if let studentId {
            try container.encode(studentId, forKey: .studentId)
        }
        
        if let studentName {
            try container.encode(studentName, forKey: .studentName)
        }
        
        if let studentNIS {
            try container.encode(studentNIS, forKey: .studentNIS)
        }
        
        
        if let categoryId {
            try container.encode(categoryId, forKey: .categoryId)
        }
        
        if let inventoryName {
            try container.encode(inventoryName, forKey: .inventoryName)
        }
        
        if let status {
            try container.encode(status, forKey: .status)
        }
        
        if let place {
            try container.encode(place, forKey: .place)
        }
        
        if let stock {
            try container.encode(stock, forKey: .stock)
        }
        
        if let requestedAt = requestedAt {
            try container.encode(Timestamp(date: requestedAt), forKey: .requestedAt)
        }
        
        if let borrowedAt = borrowedAt {
            try container.encode(Timestamp(date: borrowedAt), forKey: .borrowedAt)
        }
        
        if let expiredAt = expiredAt {
            try container.encode(Timestamp(date: expiredAt), forKey: .expiredAt)
        }
        
        if let returnedAt = returnedAt {
            try container.encode(Timestamp(date: returnedAt), forKey: .returnedAt)
        }
    }
}

enum HistoryStatus: String {
    case done = "Done"
    case onGoing = "On Going"
    case onProcess = "On Process"
    case ready = "Ready"
}
