//
//  ChangePasswordViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 07/12/23.
//

import SwiftUI
import FirebaseAuth

class ChangePasswordViewModel: ObservableObject {
    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    
    @Published var isShowAlert = false
    @Published var isChangeSuccess: Bool = false
    
    @Published var isError = false
    @Published var errorText = ""
    
    var buttonDisabled: Bool {
        passwordText.isEmpty || confirmPasswordText.isEmpty || passwordNotMatch
    }
    
    var passwordNotMatch: Bool {
        passwordText != confirmPasswordText
    }
    
    @MainActor
    func changePassword() {
        Auth.auth().currentUser?.updatePassword(to: passwordText, completion: { error in
            if let error {
                self.errorText = error.localizedDescription
                self.isError = true
            } else {
                self.isChangeSuccess = true
                self.isError = false
            }
            self.isShowAlert = true
        })
    }
}
