//
//  ChangeProfileViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 11/12/23.
//

import SwiftUI
import PhotosUI

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
    
    @MainActor
    func getUserData() {
        guard userData == nil else { return }
        
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
            
        }
    }
}
