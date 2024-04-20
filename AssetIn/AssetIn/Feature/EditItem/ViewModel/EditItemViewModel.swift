//
//  EditItemViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI
import PhotosUI

class EditItemViewModel: ObservableObject {
    private let inventoryID: String
    
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorText = ""
    @Published var isShowAlert = false
    
    @Published var inventoryData: Inventaris?
    
    @Published var inventoryName = ""
    @Published var inventoryStock = ""
    @Published var imagePlaceholder = UIImage()
    @Published var selectedImage: PhotosPickerItem? = nil
    @Published var isShowImagePicker = false
    
    var acceptButtonDisabled: Bool {
        inventoryName.isEmpty || inventoryStock.isEmpty
    }
    
    init(inventoryID: String) {
        self.inventoryID = inventoryID
    }
    
    @MainActor
    func getInventory() {
        
    }
    
    @MainActor
    func updateInventoryData() {
        if imagePlaceholder == UIImage() {
            addData("")
        } else {
            uploadImage()
        }
    }
    
    @MainActor
    func uploadImage() {
        withAnimation {
            isLoading = true
        }
        guard let imageData = imagePlaceholder.jpegData(compressionQuality: 0.5) else { return }
        
    }
    
    @MainActor
    func addData(_ imageURL: String) {
        
    }
    
    @MainActor
    func changeImagePlaceholder() async {
        if let data = try? await selectedImage?.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data)
        {
            withAnimation {
                self.imagePlaceholder = uiImage
            }
        }
    }
    
    @MainActor
    func deleteItem(perform: @escaping () -> Void) {
        
    }
}
    
