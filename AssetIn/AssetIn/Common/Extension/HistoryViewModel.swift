//
//  HistoryViewModel.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    private let loanRepository: LoanRepository
    
    @Published var loans = [Loan]()
    @Published var status:  LoanStatus
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowAlert = false
    
    init(
        status: LoanStatus? = .request,
        loanRepository: LoanRepository = LoanDefaultRepository()
    ) {
        self.status = status ?? .request
        self.loanRepository = loanRepository
    }
    
    @MainActor
    func onAppear() {
        getLoanHistory(status: status)
    }
    
    @MainActor
    func getLoanHistory(status: LoanStatus) {
        self.status = status
        Task {
            let response = await loanRepository.getUserLoanList(status: status)
            
            switch response {
            case .success(let success):
                withAnimation {
                    loans = success
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
    
    func statusColor(_ status: LoanStatus?) -> Color {
        switch status {
        case .ready, .done: .AssetIn.green
        case .onGoing: .AssetIn.purple
        default: .AssetIn.orange
        }
    }
}
