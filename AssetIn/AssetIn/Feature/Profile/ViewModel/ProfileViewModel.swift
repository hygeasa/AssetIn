//
//  ProfileViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 05/12/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") var loginStatus: Int = 0
    @AppStorage("USER_ID") var userId: String = ""
    
    @Published var userData: User?
    
    var isAdmin: Bool {
        loginStatus == 2
    }
    
    @MainActor
    func getUserData() {
        guard userData == nil else { return }
    }
    
    func logout(perform: @escaping () -> Void) {
        withAnimation {
            loginStatus = 0
            userId = ""
        }
        perform()
    }
}
