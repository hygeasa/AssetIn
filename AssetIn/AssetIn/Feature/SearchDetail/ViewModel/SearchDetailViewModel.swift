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
    
    @Published var userData: User?
    
    @Published var inventarisList: [Inventaris] = []
    var searchedInventory: [Inventaris] {
        if searchText.isEmpty {
            inventarisList
        } else {
            inventarisList.filter({
                $0.namaInventaris.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    @Published var searchText: String = ""
    
    @Published var isShowAlert = false
    
    @Published var currentInventory: Inventaris?
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
    func updateOrRequestInventory(_ data: Inventaris) {
        isAdmin ? updateInventory() : requestBorrow(data)
    }
    
    @MainActor
    func updateInventory() {
        if let currentInventory, let id = currentInventory.id {
            database.collection("Inventaris").document(id)
                .updateData(["stock":Int(self.quantity) ?? currentInventory.stock]) { error in
                    if let error {
                        print(error)
                    } else {
                        self.isRequest = true
                        self.getInventories()
                    }
                }
        }
    }
    
    @MainActor
    func requestBorrow(_ data: Inventaris) {
        if let id = data.id {
            let request: History = .init(
                inventoryId: id,
                studentId: userId,
                studentName: userData?.nama,
                studentNIS: userData?.nis,
                categoryId: data.categoryId,
                inventoryName: data.namaInventaris,
                status: HistoryStatus.onProcess.rawValue,
                stock: Int(quantity),
                requestedAt: .now
            )
            
            database.collection("Peminjaman").document(request.id ?? "")
                .setData(request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.isRequest = true
                    }
                }
        }
    }
    
    @MainActor
    func getUserData() {
        guard userData == nil else { return }
        database.collection("Pengguna").document(userId)
            .getDocument { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot,
                          let data = try? snapshot.data(as: User.self)
                {
                    self.userData = data
                }
            }
    }
}
