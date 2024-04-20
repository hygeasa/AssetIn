//
//  TakeViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI

class TakeViewModel : ObservableObject {
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var historyData: [History] = []
    @Published var quantity = "1"
    
    @Published var isShowAlert = false
    @Published var isRequest = false
    
    @MainActor
    func getHistoryData() {
        
    }
}
