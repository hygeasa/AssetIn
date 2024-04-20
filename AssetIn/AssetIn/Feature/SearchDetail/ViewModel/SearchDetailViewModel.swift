//
//  SearchDetailViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI

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
    
    init(category: Category) {
        self.category = category
    }
    
    func getInventories() {
        
    }
    
    @MainActor
    func updateOrRequestInventory(_ data: Inventaris) {
        isAdmin ? updateInventory() : requestBorrow(data)
    }
    
    @MainActor
    func updateInventory() {
        
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
        }
    }
    
    @MainActor
    func getUserData() {
        guard userData == nil else { return }
    }
}
