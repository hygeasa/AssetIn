//
//  FindReportViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

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
        
    }
    
    @MainActor
    private func getBorrowData(startOfDay: Date, endOfDay: Date) {
        
    }
    
    @MainActor
    private func getReturnData(startOfDay: Date, endOfDay: Date) {
        
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
