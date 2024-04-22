//
//  InventoryViewModel.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

final class InventoryViewModel: ObservableObject {
    
    private let inventoryRepository: InventoryRepository
    
    @Published var inventories = [Inventory]()
    @Published var category: CategoryType
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowAlert = false
    
    init(
        category: CategoryType,
        inventoryRepository: InventoryRepository = InventoryDefaultRepository()
    ) {
        self.category = category
        self.inventoryRepository = inventoryRepository
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
