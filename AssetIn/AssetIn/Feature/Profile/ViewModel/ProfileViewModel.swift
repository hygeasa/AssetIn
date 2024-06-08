//
//  ProfileViewModel.swift
//  AssetIn
//
//  Created by Irham Naufal on 08/06/24.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    private let authRepository: AuthRepository
    
    @Published var user: User?
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowAlert = false
    
    @Published var isShowLogoutAlert = false
    
    init(authRepository: AuthRepository = AuthDefaultRepository()) {
        self.authRepository = authRepository
    }
    
    @MainActor
    func onAppear() {
        getUserData()
    }
    
    @MainActor
    func getUserData() {
        Task {
            let response = await authRepository.getUserData()
            
            switch response {
            case .success(let success):
                withAnimation {
                    user = success
                }
            case .failure(let failure):
                handleDefaultError(failure)
            }
        }
    }
    
    @MainActor
    func logOut(popToRoot: @escaping () -> Void) {
        Task {
            let action = await authRepository.logout()
            
            switch action {
            case .success:
                popToRoot()
                SystemSettings.shared.mainTabSelection = .home
            case .failure(let failure):
                handleDefaultError(failure)
            }
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
