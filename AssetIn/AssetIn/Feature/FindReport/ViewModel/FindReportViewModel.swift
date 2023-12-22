//
//  FindReportViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class FindReportViewModel: ObservableObject {
    @Published var date: Date
    
    @Published var requestData = [History]()
    @Published var borrowData = [History]()
    @Published var returnData = [History]()
    
    var historyData: [History] {
        var data = [History]()
        data.append(contentsOf: requestData)
        data.append(contentsOf: borrowData)
        data.append(contentsOf: returnData)
        
        return data.unique()
    }
    
    private var database = Firestore.firestore()
    
    init(date: Date) {
        self.date = date
    }
    
    @MainActor
    func getHistoryData() {
        getRequestData()
        getBorrowData()
        getReturnData()
    }
    
    @MainActor
    private func getRequestData() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        database.collection("Peminjaman")
            .whereField("requestedAt.seconds", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
            .whereField("requestedAt.seconds", isLessThan: endOfDay.timeIntervalSince1970)
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    self.requestData = snapshot.documents.compactMap{
                        try? $0.data(as: History.self)
                    }
                }
            }
    }
    
    @MainActor
    private func getBorrowData() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        database.collection("Peminjaman")
            .whereField("borrowedAt.seconds", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
            .whereField("borrowedAt.seconds", isLessThan: endOfDay.timeIntervalSince1970)
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    self.borrowData = snapshot.documents.compactMap{
                        try? $0.data(as: History.self)
                    }
                }
            }
    }
    
    @MainActor
    private func getReturnData() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        database.collection("Peminjaman")
            .whereField("returnedAt.seconds", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
            .whereField("returnedAt.seconds", isLessThan: endOfDay.timeIntervalSince1970)
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    self.returnData = snapshot.documents.compactMap{
                        try? $0.data(as: History.self)
                    }
                }
            }
    }
    
    func statusColor(_ status: String) -> Color {
        switch status {
        case "Ready":
            return .blue
        case "Done":
            return .AssetIn.green
        case "On Going":
            return .AssetIn.purple
        default:
            return .AssetIn.orange
        }
    }
}
