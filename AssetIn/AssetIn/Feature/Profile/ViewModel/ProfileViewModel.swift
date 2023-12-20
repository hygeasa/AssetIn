//
//  ProfileViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 05/12/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    
    @AppStorage("LOGIN_STATUS") var loginStatus: Int = 0
    @AppStorage("USER_ID") var userId: String = ""
    
    @Published var userData: User?
    
    var isAdmin: Bool {
        loginStatus == 2
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
    
    func logout() {
        try? Auth.auth().signOut()
        withAnimation {
            loginStatus = 0
            userId = ""
        }
    }
}
