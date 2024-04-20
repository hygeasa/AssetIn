//
//  EditDataViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 13/12/23.
//

import SwiftUI
import PhotosUI

class EditDataViewModel : ObservableObject {
    
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorText = ""
    @Published var isShowAlert = false
    
    @Published var furnitureData: [Inventaris] = []
    @Published var musicData: [Inventaris] = []
    @Published var classroomData: [Inventaris] = []
    @Published var labData: [Inventaris] = []
    @Published var sportsData: [Inventaris] = []
    @Published var libraryData: [Inventaris] = []
    
    @Published var currentCategory = ""
    @Published var inventoryName = ""
    @Published var inventoryStock = ""
    @Published var imagePlaceholder = UIImage()
    @Published var selectedImage: PhotosPickerItem? = nil
    @Published var isShowAddData = false
    @Published var isShowImagePicker = false
    
    var acceptButtonDisabled: Bool {
        currentCategory.isEmpty || inventoryName.isEmpty || inventoryStock.isEmpty || imagePlaceholder == UIImage()
    }
    
    @MainActor
    func getInventories() {
        getFurnitureData()
        getMusicData()
        getClassroomData()
        getLabData()
        getSportsData()
        getLibraryData()
    }
    
    @MainActor
    private func getFurnitureData() {
        
    }
    
    @MainActor
    private func getMusicData() {
        
    }
    
    @MainActor
    private func getClassroomData() {
        
    }
    
    @MainActor
    private func getLabData() {
        
    }
    
    @MainActor
    private func getSportsData() {
        
    }
    
    @MainActor
    private func getLibraryData() {
        
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
        let request = Inventaris(
            category: currentCategory,
            categoryId: currentCategory.uppercased(),
            namaInventaris: inventoryName,
            stock: Int(inventoryStock) ?? 0,
            gambar: imageURL
        )
        
    }
    
    @MainActor
    func resetData() {
        currentCategory = ""
        inventoryName = ""
        inventoryStock = ""
        imagePlaceholder = UIImage()
        isShowAddData = false
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
}
