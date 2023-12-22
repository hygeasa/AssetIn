//
//  EditItemViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class EditItemViewModel: ObservableObject {
    private var database = Firestore.firestore()
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
        database.collection("Inventaris").document(inventoryID)
            .getDocument { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    self.inventoryData = try? snapshot.data(as: Inventaris.self)
                    self.inventoryName = self.inventoryData?.namaInventaris ?? ""
                    self.inventoryStock = "\(self.inventoryData?.stock ?? 0)"
                }
            }
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
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageName = UUID().uuidString
        let imageRef = storageRef.child("inventory/\(imageName).jpg")
        
        _ = imageRef.putData(imageData, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                self.isError = true
                self.errorText = error?.localizedDescription ?? "An error occured when uploading photo"
                self.isShowAlert = true
                withAnimation {
                    self.isLoading = false
                }
                return
            }
            
            imageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    self.isError = true
                    self.errorText = error?.localizedDescription ?? "An error occured when uploading photo"
                    withAnimation {
                        self.isLoading = false
                    }
                    self.isShowAlert = true
                    return
                }
                
                self.addData(downloadURL.absoluteString)
            }
        }
    }
    
    @MainActor
    func addData(_ imageURL: String) {
        if let inventoryData {
            let request: [String:Any] = [
                "nama_inventaris": inventoryName,
                "stock": Int(inventoryStock) ?? 0,
                "gambar": imageURL.isEmpty ? inventoryData.gambar : imageURL
            ]
            
            database.collection("Inventaris").document(inventoryID)
                .updateData(request) { error in
                    if let error {
                        self.isError = true
                        self.errorText = error.localizedDescription
                    } else {
                        self.isError = false
                        withAnimation {
                            self.isLoading = false
                        }
                        self.isShowAlert = true
                    }
                }
        }
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
    
