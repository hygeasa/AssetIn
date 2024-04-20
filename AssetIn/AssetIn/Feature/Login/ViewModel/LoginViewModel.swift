//
//  LoginViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var emailText: String = ""
    @Published var usernameText: String = ""
    @Published var NISText: String = ""
    @Published var passwordText: String = ""
    @Published var isRegister: Bool = false
    
    @Published var isAdmin: Bool
    
    @Published var isError = false
    @Published var errorText = ""
    
    init(isAdmin: Bool) {
        self.isAdmin = isAdmin
    }
    
    func disableButton() -> Bool {
        if isRegister {
            return emailText.isEmpty || passwordText.isEmpty || NISText.isEmpty || usernameText.isEmpty
        } else {
            return emailText.isEmpty || passwordText.isEmpty
        }
    }
    
    @MainActor
    func loginOrRegister(completion: @escaping () -> Void) {
        isRegister ? registerUser(completion: completion) : login(completion: completion)
    }
    
    @MainActor
    func login(completion: @escaping () -> Void) {
        
    }
    
    @MainActor
    func registerUser(completion: @escaping () -> Void) {
        
    }
    
    private func storeUserData(id: String, completion: @escaping () -> Void) {
        let userData = User(id: id, nama: usernameText, nis: NISText, isAdmin: false, email: emailText).toJSON()
        
    }
    
    @MainActor
    private func checkAdmin(userId: String, completion: @escaping () -> Void) {
        
    }
}
