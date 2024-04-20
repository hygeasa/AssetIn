//
//  OnGoingViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 01/12/23.
//

import SwiftUI

class OnGoingViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var historyData: [History] = []
    
    var isAdmin: Bool {
        loginStatus == 2
    }
    
    @MainActor
    func getHistoryData() {
        
    }
    
    func statusColor(_ status: String) -> Color {
        switch status {
        case HistoryStatus.onGoing.rawValue:
            return .AssetIn.purple
        default:
            return .AssetIn.orange
        }
    }
}
