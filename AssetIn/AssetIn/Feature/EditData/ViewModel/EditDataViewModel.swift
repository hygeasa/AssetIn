//
//  EditDataViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 13/12/23.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class EditDataViewModel : ObservableObject {
    
    private var database = Firestore.firestore()
    
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
        database.collection("Inventaris").whereField("category_id", isEqualTo: "FURNITURE")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.furnitureData = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    private func getMusicData() {
        database.collection("Inventaris").whereField("category_id", isEqualTo: "MUSIC")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.musicData = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    private func getClassroomData() {
        database.collection("Inventaris").whereField("category_id", isEqualTo: "CLASSROOM")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.classroomData = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    private func getLabData() {
        database.collection("Inventaris").whereField("category_id", isEqualTo: "LABORATORY")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.labData = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    private func getSportsData() {
        database.collection("Inventaris").whereField("category_id", isEqualTo: "SPORTS")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.sportsData = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
            }
    }
    
    @MainActor
    private func getLibraryData() {
        database.collection("Inventaris").whereField("category_id", isEqualTo: "LIBRARY")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.libraryData = snapshot?.documents.compactMap {
                        try? $0.data(as: Inventaris.self)
                    } ?? []
                }
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
        let request = Inventaris(
            category: currentCategory,
            categoryId: currentCategory.uppercased(),
            namaInventaris: inventoryName,
            stock: Int(inventoryStock) ?? 0,
            gambar: imageURL
        )
        
        database.collection("Inventaris").document(request.id ?? UUID().uuidString)
            .setData(request.toJSON()) { error in
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
