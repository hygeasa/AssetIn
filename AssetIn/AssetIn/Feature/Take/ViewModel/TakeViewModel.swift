//
//  TakeViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class TakeViewModel : ObservableObject {
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
            .whereField("status", isEqualTo: "On Process")
            .whereField("place", isNotEqualTo: "")
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
}
