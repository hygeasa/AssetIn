//
//  HomeViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 21/11/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeViewModel : ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var userData: User?
    @Published var userclass : String = "2A"
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var category : String = "School suplies"
    @Published var lending : String = "05/06/2023"
    
    @Published var borrowedItem: [History] = []
    
    @Published var news: [News] = []
    @Published var isShowSafari = false
    
    @Published var currentNews: News?
    @Published var isShowEditNews = false
    @Published var newsTitle = ""
    @Published var newsURL = ""
    
    var isAdmin: Bool {
        loginStatus == 2
    }
    
    var updateNewsDisabled: Bool {
        newsTitle.isEmpty || newsURL.isEmpty || currentNews == nil
    }
    
    @Published var isAccept : Bool = true
    
    @Published var place : String = ""
    @Published var deadlineAlert : String = ""
    
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
    func getNewsData() {
        guard news.isEmpty else { return }
        database.collection("Berita")
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    withAnimation {
                        self.news = snapshot.documents.compactMap({ data in
                            try? data.data(as: News.self)
                        })
                    }
                }
            }
    }
    
    @MainActor
    func showEditNews(_ data: News) {
        currentNews = data
        newsTitle = data.title ?? ""
        newsURL = data.url ?? ""
        isShowEditNews = true
    }
    
    @MainActor
    func updateNews() {
        if let currentNews,
           let id = currentNews.id,
           let thumbnail = currentNews.thumbnail
        {
            let newData = News(
                id: id,
                thumbnail: thumbnail,
                title: self.newsTitle,
                url: self.newsURL
            )
            
            database.collection("Berita").document(id)
                .updateData(newData.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.resetNewsData()
                    }
                }
        }
    }
    
    @MainActor
    func resetNewsData() {
        currentNews = nil
        newsTitle = ""
        newsURL = ""
        isShowEditNews = false
    }
}
