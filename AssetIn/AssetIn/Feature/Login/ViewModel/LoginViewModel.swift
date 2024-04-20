//
//  LoginViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    private let authRepository: AuthRepository
    private let settings = SystemSettings.shared
    
    @Published var emailText = ""
    @Published var usernameText = ""
    @Published var NISText = ""
    @Published var passwordText = ""
    @Published var confirmPasswordText = ""
    @Published var isRegister = false
    
    @Published var isAdmin: Bool
    
    @Published var isShowAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    init(isAdmin: Bool, authRepository: AuthRepository = AuthDefaultRepository()) {
        self.isAdmin = isAdmin
        self.authRepository = authRepository
    }
    
    func disableButton() -> Bool {
        if isRegister {
            return emailText.isEmpty || passwordText.isEmpty || confirmPasswordText.isEmpty || NISText.isEmpty || usernameText.isEmpty
        } else {
            return emailText.isEmpty || passwordText.isEmpty
        }
    }
    
    @MainActor
    func loginOrRegister(completion: @escaping () -> Void) {
        Task {
            isRegister ? await register() : await login(completion: completion)
        }
    }
    
    @MainActor
    func login(completion: @escaping () -> Void) async {
        let role = emailText == "superadmin@mail.com" ? "superadmin" : (isAdmin ? "admin" : "siswa")
        
        let response = await authRepository.login(email: emailText, password: passwordText)
        
        switch response {
        case .success(let success):
            settings.role = role
            completion()
        case .failure(let failure):
            handleDefaultError(failure)
        }
    }
    
    @MainActor
    func register() async {
        let body = RegisterBody(
            name: usernameText,
            email: emailText,
            password: passwordText,
            passwordConfirmation: confirmPasswordText,
            role: isAdmin ? "admin" : "siswa",
            nip: isAdmin ? NISText : nil,
            nis: isAdmin ? nil : NISText
        )
        
        let response = await authRepository.register(with: body)
        
        switch response {
        case .success:
            alertTitle = "Registration Successful"
            alertMessage = "Please wait for approval from the admin before you can Sign In."
            isShowAlert = true
            
        case .failure(let failure):
            handleDefaultError(failure)
        }
    }
    
    @MainActor
    func handleDefaultError(_ error: Error) {
        alertTitle = "Oopss.."
        if let error = error as? ServerError {
            alertMessage = error.message.orEmpty()
        } else {
            alertMessage = error.localizedDescription
        }
        isShowAlert = true
    }
}
