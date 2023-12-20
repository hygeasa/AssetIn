//
//  OnGoingViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 01/12/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class OnGoingViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var historyData: [History] = []
    
    var isAdmin: Bool {
        loginStatus == 2
    }
    
    private var database = Firestore.firestore()
    
    @MainActor
    func getHistoryData() {
        database.collection("Peminjaman").whereField("studentId", isEqualTo: userId)
            .whereField("status", isNotEqualTo: "Done")
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
    
    func statusColor(_ status: String) -> Color {
        switch status {
        case HistoryStatus.done.rawValue:
            return .AssetIn.green
        case HistoryStatus.onGoing.rawValue:
            return .AssetIn.purple
        default:
            return .AssetIn.orange
        }
    }
}
