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
    
    @Published var inventarisList: [Inventaris] = []
    
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
    
    private let db = Firestore.firestore()
    
    init(category: Category) {
        self.category = category
    }
    
    func getInventories() {
        db.collection("Inventaris").whereField("category_id", isEqualTo: category.id)
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
}
