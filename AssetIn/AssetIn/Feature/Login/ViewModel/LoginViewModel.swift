//
//  LoginViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

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
    
    private let auth = Auth.auth()
    private let database = Firestore.firestore()
    
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
        auth.signIn(withEmail: emailText, password: passwordText) { result, error in
            if let error {
                self.isError = true
                self.errorText = error.localizedDescription
            } else if let result {
                if self.isAdmin {
                    self.checkAdmin(userId: result.user.uid) {
                        self.loginStatus = 2
                        completion()
                        self.userId = result.user.uid
                    }
                } else {
                    self.loginStatus = 1
                    completion()
                    self.userId = result.user.uid
                }
            }
        }
    }
    
    @MainActor
    func registerUser(completion: @escaping () -> Void) {
        auth.createUser(withEmail: emailText, password: passwordText) { result, error in
            if let error {
                self.isError = true
                self.errorText = error.localizedDescription
            }
            
            else if let result {
                self.storeUserData(id: result.user.uid, completion: completion)
                self.userId = result.user.uid
            }
        }
    }
    
    private func storeUserData(id: String, completion: @escaping () -> Void) {
        let userData = User(id: id, nama: usernameText, nis: NISText, isAdmin: false, email: emailText).toJSON()
        
        Firestore.firestore().collection("Pengguna")
            .document(id)
            .setData(userData) { error in
                if let error = error {
                    self.isError = true
                    self.errorText = error.localizedDescription
                } else {
                    self.loginStatus = 1
                    completion()
                }
            }
    }
    
    @MainActor
    private func checkAdmin(userId: String, completion: @escaping () -> Void) {
        database.collection("Pengguna").document(userId)
            .getDocument { result, error in
                if let error {
                    print("error")
                } else if let result {
                    if let user = try? result.data(as: User.self),
                       user.isAdmin {
                        completion()
                    } else {
                        self.errorText = "You don't have access to be an admin"
                        self.isError = true
                    }
                }
            }
    }
}
