//
//  NotificationViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 04/12/23.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") var loginStatus: Int = 0
    
    @Published var name : String = "Iam jelek"
    @Published var NIS : String = "1234"
    @Published var userclass : String = "2A"
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var category : String = "School suplies"
    @Published var lending : String = "05/06/2023"
    @Published var timeNotification : String = "now"
    @Published var textNotification : String = "Thank you for returning the basketball."
    @Published var processNotification : String = "Your basketball is on process."
    @Published var waitNotification : String = "Wait for your basketball request."
    @Published var takeplaceNotification : String = "You can take it at koperasi before "
    @Published var oldtimeNotification : String = "2 days ago"
    
    var isAdmin: Bool {
        loginStatus == 2
    }
}
