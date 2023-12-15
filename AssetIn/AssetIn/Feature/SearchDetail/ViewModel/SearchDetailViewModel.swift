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
    
    @Published var inventarisList: [Inventaris] = []
    
    @Published var search: String = ""
    @Published var category: String = "School Supplies"
    @Published var inventaris: String = "Proyektor"
    @Published var stock: Int = 4
    
    @Published var isShowAlert = false
    @Published var quantity = "1"
    @Published var isRequest = false
    
    @Published var isAdmin : Bool = true
    
    private let db = Firestore.firestore()
    
    func getInventories() {
        db.collection("Inventaris").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.inventarisList = querySnapshot?.documents.compactMap {
                    try? $0.data(as: Inventaris.self)
                } ?? [] 
            }
        }
    }
}
