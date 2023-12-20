//
//  HistoryViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class HistoryViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var historyData: [History] = []
    @Published var quantity = "1"
    
    @Published var isShowAlert = false
    @Published var isRequest = false
    
    private var database = Firestore.firestore()
    
    @MainActor
    func getHistoryData() {
        database.collection("Peminjaman").whereField("studentId", isEqualTo: userId)
            .whereField("status", isEqualTo: "Done")
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else {
                    self.historyData = snapshot?.documents.compactMap{
                        try? $0.data(as: History.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    func requestBorrow(_ data: History) {
        if let id = data.inventoryId {
            let request: History = .init(
                inventoryId: id,
                studentId: userId,
                categoryId: data.categoryId,
                inventoryName: data.inventoryName,
                status: HistoryStatus.onProcess.rawValue,
                stock: Int(quantity),
                requestedAt: .now
            )
            
            do {
                try database.collection("Peminjaman")
                    .addDocument(from: request) { error in
                        if let error {
                            print(error)
                        } else {
                            self.isRequest = true
                        }
                    }
            } catch(let error) {
                print(error)
            }
        }
    }
}


