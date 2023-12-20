//
//  ChangeProfileViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 11/12/23.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ChangeProfileViewModel : ObservableObject {
    
    @AppStorage("USER_ID") var userId: String = ""
    
    @Published var isShowAlert: Bool = false
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorText = ""
    
    @Published var imagePlaceholder = UIImage()
    var selectedImage: PhotosPickerItem? = nil
    
    @Published var userData: User?
    
    @Published var isShowImagePicker = false
    
    var buttonDisabled: Bool {
        imagePlaceholder == UIImage()
    }
    
    private var database = Firestore.firestore()
    
    @MainActor
    func getUserData() {
        guard userData == nil else { return }
        database.collection("Pengguna").document(userId)
            .getDocument { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot,
                          let data = try? snapshot.data(as: User.self)
                {
                    self.userData = data
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
    
    @MainActor
    func uploadImage() {
        withAnimation {
            isLoading = true
        }
        guard let imageData = imagePlaceholder.jpegData(compressionQuality: 0.5) else { return }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageName = UUID().uuidString
        let imageRef = storageRef.child("profile/\(userId)/\(imageName).jpg")
        
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
                
                self.storeProfilePhoto(downloadURL)
            }
        }
    }
    
    @MainActor
    private func storeProfilePhoto(_ url: URL?) {
        if let url, let userData {
            let request = User(
                id: self.userId,
                nama: userData.nama,
                nis: userData.nis,
                isAdmin: userData.isAdmin,
                email: userData.email,
                imageURL: url.absoluteString
            )
            
            database.collection("Pengguna").document(userId)
                .updateData(request.toJSON()) { error in
                    if let error {
                        self.isError = true
                        self.errorText = error.localizedDescription
                    } else {
                        self.isError = false
                    }
                    
                    withAnimation {
                        self.isLoading = false
                    }
                    self.isShowAlert = true
                }
        }
    }
}
