//
//  HistoryViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var userData: User?
    
    @Published var historyData: [History] = []
    @Published var quantity = "1"
    
    @Published var isShowAlert = false
    @Published var isRequest = false
    
    @MainActor
    func getHistoryData() {
        
    }
    
    @MainActor
    func requestBorrow(_ data: History) {
        if let id = data.inventoryId {
            let request: History = .init(
                inventoryId: id,
                studentId: userId,
                studentName: userData?.nama,
                studentNIS: userData?.nis,
                categoryId: data.categoryId,
                inventoryName: data.inventoryName,
                status: HistoryStatus.onProcess.rawValue,
                stock: Int(quantity),
                requestedAt: .now
            )
        }
    }
    
    @MainActor
    func getUserData() {
        guard userData == nil else { return }
    }
}


