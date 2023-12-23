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
    private let filter: [String]
    
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
    
    init(date: Date, filter: [String]) {
        self.date = date
        self.filter = filter
    }
    
    @MainActor
    func getHistoryData() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        getRequestData(startOfDay: startOfDay, endOfDay: endOfDay)
        getBorrowData(startOfDay: startOfDay, endOfDay: endOfDay)
        getReturnData(startOfDay: startOfDay, endOfDay: endOfDay)
    }
    
    @MainActor
    private func getRequestData(startOfDay: Date, endOfDay: Date) {
        if filter.isEmpty {
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
        } else {
            database.collection("Peminjaman")
                .whereField("requestedAt.seconds", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
                .whereField("requestedAt.seconds", isLessThan: endOfDay.timeIntervalSince1970)
                .whereField("categoryId", in: filter)
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
    }
    
    @MainActor
    private func getBorrowData(startOfDay: Date, endOfDay: Date) {
        if filter.isEmpty {
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
        } else {
            database.collection("Peminjaman")
                .whereField("borrowedAt.seconds", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
                .whereField("borrowedAt.seconds", isLessThan: endOfDay.timeIntervalSince1970)
                .whereField("categoryId", in: filter)
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
    }
    
    @MainActor
    private func getReturnData(startOfDay: Date, endOfDay: Date) {
        if filter.isEmpty {
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
        } else {
            database.collection("Peminjaman")
                .whereField("returnedAt.seconds", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
                .whereField("returnedAt.seconds", isLessThan: endOfDay.timeIntervalSince1970)
                .whereField("categoryId", in: filter)
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
