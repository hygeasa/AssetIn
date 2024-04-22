//
//  InventoryViewModel.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

final class InventoryViewModel: ObservableObject {
    
    private let inventoryRepository: InventoryRepository
    private let loanRepository: LoanRepository
    private let authRepository: AuthRepository
    
    @Published var inventories = [Inventory]()
    @Published var category: CategoryType
    
    @Published var currentInventory: Inventory?
    @Published var quantityTextField = ""
    @Published var loanDate = Date()
    @Published var loanBody = LoanRequest(inventoryId: 0, userId: 0, quantity: 0, dueDate: "")
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowAlert = false
    
    var disableBorrow: Bool {
        return Int(quantityTextField).orZero() < 1
    }
    
    init(
        category: CategoryType,
        inventoryRepository: InventoryRepository = InventoryDefaultRepository(),
        loanRepository: LoanRepository = LoanDefaultRepository(),
        authRepository: AuthRepository = AuthDefaultRepository()
    ) {
        self.category = category
        self.inventoryRepository = inventoryRepository
        self.loanRepository = loanRepository
        self.authRepository = authRepository
    }
    
    @MainActor
    func onAppear() {
        getInventoryList(category: category)
    }
    
    @MainActor
    func getInventoryList(category: CategoryType) {
        self.category = category
        Task {
            let response = await inventoryRepository.getList(categoryId: category)
            
            switch response {
            case .success(let success):
                withAnimation {
                    inventories = success
                }
            case .failure(let failure):
                handleDefaultError(failure)
            }
        }
    }
    
    @MainActor
    func openDetail(_ inventory: Inventory) {
        withAnimation(.spring) {
            currentInventory = inventory
            loanBody.inventoryId = (inventory.id).orZero()
        }
    }
    
    @MainActor
    func closeDetail() {
        withAnimation(.spring) {
            currentInventory = nil
            loanBody = LoanRequest(inventoryId: 0, userId: 0, quantity: 0, dueDate: "")
            quantityTextField = ""
            loanDate = .now
        }
    }
    
    @MainActor
    func createLoan() {
        Task {
            guard let userId = await getUserId(),
                  let quantity = Int(quantityTextField)
            else { return }
            
            loanBody.userId = userId
            loanBody.quantity = quantity
            loanBody.dueDate = loanDate.toServerFormat
            
            let response = await loanRepository.create(body: loanBody)
            
            switch response {
            case .success:
                alertTitle = "Yeay 🎉"
                alertMessage = "Your request is under process."
                isShowAlert = true
                closeDetail()
            case .failure(let failure):
                handleDefaultError(failure)
            }
        }
    }
    
    func getUserId() async -> Int? {
        let response = await authRepository.getUserData()
        
        switch response {
        case .success(let success):
            return success.id.orZero()
        case .failure(let failure):
            await handleDefaultError(failure)
        }
        
        return nil
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
