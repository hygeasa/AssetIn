//
//  SearchDetailViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class SearchDetailViewModel : ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var inventarisList: [Inventaris] = []
    @Published var inventoryId: String?
    
    @Published var searchText: String = ""
    
    @Published var isShowAlert = false
    @Published var quantity = "1"
    @Published var isRequest = false
    
    var isAdmin: Bool {
        loginStatus == 2
    }
    
    private let category: Category
    var categoryText: String {
        category.name
    }
    
    private let database = Firestore.firestore()
    
    init(category: Category) {
        self.category = category
    }
    
    func getInventories() {
        database.collection("Inventaris").whereField("category_id", isEqualTo: category.id)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.inventarisList = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    func updateOrRequestInventory() {
        isAdmin ? updateInventory() : requestBorrow()
    }
    
    @MainActor
    func updateInventory() {
        self.isRequest = true
    }
    
    @MainActor
    func requestBorrow() {
        if let inventoryId {
            let request: History = .init(
                inventoryId: inventoryId,
                studentId: userId,
                status: HistoryStatus.onProcess.rawValue,
                stock: Int(quantity),
                borrowedAt: nil,
                expiredAt: nil,
                returnedAt: nil
            )
            
            database.collection("Peminjaman")
                .addDocument(data: request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.isRequest = true
                        self.inventoryId = nil
                    }
                }
        }
    }
}
