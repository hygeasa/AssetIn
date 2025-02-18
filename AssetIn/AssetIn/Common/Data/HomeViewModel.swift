//
//  HomeViewModel.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    private let announcementRepository: AnnouncementRepository
    private let authRepository: AuthRepository
    private let loanRepository: LoanRepository
    
    @Published var announcements = [Announcement]()
    @Published var currentBanner = 0
    
    @Published var user: User?
    
    @Published var loans = [Loan]()
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowAlert = false
    
    @Published var isShowSafari = false
    
    
    init(
        announcementRepository: AnnouncementRepository = AnnouncementDefaultRepository(),
        authRepository: AuthRepository = AuthDefaultRepository(),
        loanRepository: LoanRepository = LoanDefaultRepository()
    ) {
        self.announcementRepository = announcementRepository
        self.authRepository = authRepository
        self.loanRepository = loanRepository
    }
    
    @MainActor
    func onAppear() {
        getAnnonucementList()
        getUserData()
        getLoanList()
    }
    
    @MainActor
    func getAnnonucementList() {
        Task {
            let response = await announcementRepository.getList()
            
            switch response {
            case .success(let success):
                withAnimation {
                    announcements = success
                }
            case .failure(let failure):
                handleDefaultError(failure)
            }
        }
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
    func getLoanList() {
        Task {
            let response = await loanRepository.homeGetUseLoanList()
            
            switch response {
            case .success(let success):
                withAnimation {
                    loans = success.sorted(by: { ($0.status?.rawValue).orEmpty() < ($1.status?.rawValue).orEmpty() })
                }
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
