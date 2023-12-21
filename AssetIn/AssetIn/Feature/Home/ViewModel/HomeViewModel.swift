//
//  HomeViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 21/11/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum AdminHeaderSection {
    case request
    case ready
    case onGoing
}

class HomeViewModel : ObservableObject {
    
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    @AppStorage("USER_ID") private var userId: String = ""
    
    @Published var currentSection: AdminHeaderSection = .request
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertAction: () -> Void = {}
    
    @Published var userData: User?
    
    @Published var news: [News] = []
    @Published var isShowSafari = false
    
    @Published var historyData: [History] = []
    @Published var readyData: [History] = []
    @Published var onGoingData: [History] = []
    
    var currentSectionData: [History] {
        switch currentSection {
        case .request:
            historyData
        case .ready:
            readyData
        case .onGoing:
            onGoingData
        }
    }
    
    var statusText: String {
        switch currentSection {
        case .request:
            "On Process"
        case .ready:
            "Ready"
        case .onGoing:
            "On Going"
        }
    }
    
    var buttonStatusText: String {
        switch currentSection {
        case .request:
            "Accept"
        case .ready:
            "Borrowed"
        case .onGoing:
            "Returned"
        }
    }
    
    var statusColor: Color {
        switch currentSection {
        case .request:
            return .AssetIn.orange
        case .ready:
            return .blue
        case .onGoing:
            return .AssetIn.purple
        }
    }
    
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
    
    @Published var isShowAcceptBottomSheet = false
    @Published var isAccepted = false
    @Published var currentRequest: History?
    @Published var currentInventory: Inventaris?
    @Published var takePlace = ""
    @Published var currentQuantity = ""
    var currentStock: Int {
        currentInventory?.stock ?? 0
    }
    
    var isOutOfStock: Bool {
        currentStock < Int(currentQuantity) ?? 0
    }
    
    var isQuantityZero: Bool {
        currentQuantity.isEmpty || (Int(currentQuantity) ?? 0) < 1
    }
    
    var acceptButtonDisabled: Bool {
        isOutOfStock || takePlace.isEmpty || isQuantityZero
    }
    
    private var database = Firestore.firestore()
    
    func statusColor(_ status: String) -> Color {
        switch status {
        case HistoryStatus.done.rawValue:
            return .AssetIn.green
        case HistoryStatus.onGoing.rawValue:
            return .AssetIn.purple
        default:
            return .AssetIn.orange
        }
    }
    
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
    
    @MainActor
    func adminOnApper() {
        if isAdmin {
            getHistoryData()
            getReadyData()
        }
    }
    
    @MainActor
    func getHistoryData() {
        database.collection("Peminjaman").whereField("status", isEqualTo: "On Process")
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    withAnimation {
                        self.historyData = snapshot.documents.compactMap({
                            try? $0.data(as: History.self)
                        })
                    }
                }
            }
    }
    
    @MainActor
    func getReadyData() {
        database.collection("Peminjaman").whereField("status", isEqualTo: "Ready")
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    withAnimation {
                        self.readyData = snapshot.documents.compactMap({
                            try? $0.data(as: History.self)
                        })
                    }
                }
            }
    }
    
    @MainActor
    func getOnGoingData() {
        database.collection("Peminjaman").whereField("status", isEqualTo: "On Going")
            .getDocuments { snapshot, error in
                if let error {
                    print(error)
                } else if let snapshot {
                    withAnimation {
                        self.onGoingData = snapshot.documents.compactMap({
                            try? $0.data(as: History.self)
                        })
                    }
                }
            }
    }
    
    @MainActor
    func showRequestBottomSheet(_ data: History) {
        currentRequest = data
        takePlace = ""
        currentQuantity = "\(data.stock ?? 0)"
        checkCurrentStock()
        isShowAcceptBottomSheet = true
    }
    
    @MainActor
    func checkCurrentStock() {
        if let currentRequest, let id = currentRequest.inventoryId {
            database.collection("Inventaris").document(id)
                .getDocument { snapshot, error in
                    if let error {
                        print(error)
                    } else if let snapshot {
                        self.currentInventory = try? snapshot.data(as: Inventaris.self)
                    }
                }
        }
    }
    
    @MainActor
    func acceptRequest() {
        if let currentRequest, let id = currentRequest.id {
            var request = currentRequest
            request.expiredAt = Calendar.current.date(byAdding: .day, value: 1, to: .now)
            request.stock = Int(currentQuantity)
            request.status = "Ready"
            request.place = takePlace
            
            database.collection("Peminjaman").document(id)
                .updateData(request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.updateInventory()
                    }
                }
        }
    }
    
    @MainActor
    func resetCurrentRequestData() {
        adminOnApper()
        currentRequest = nil
        currentInventory = nil
        takePlace = ""
        currentQuantity = ""
        alertMessage = ""
        alertAction = {}
        isShowAcceptBottomSheet = false
    }
    
    @MainActor
    private func updateInventory() {
        if let currentInventory, let id = currentInventory.id {
            var request = currentInventory
            request.stock -= (Int(currentQuantity) ?? 0)
            
            database.collection("Inventaris").document(id)
                .updateData(request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.isAccepted = true
                    }
                }
        }
    }
    
    @MainActor
    func adminAcceptButtonAction(_ data: History) {
        switch currentSection {
        case .request:
            showRequestBottomSheet(data)
        case .ready:
            showReadyAlert(data)
        case .onGoing:
            showOnGoingAlert(data)
        }
    }
    
    @MainActor
    func showReadyAlert(_ data: History) {
        currentRequest = data
        alertMessage = "\(data.inventoryName ?? "") already borrowed by \(data.studentName ?? "")?"
        alertAction = changeToOnGoing
        isShowAlert = true
    }
    
    @MainActor
    func showOnGoingAlert(_ data: History) {
        currentRequest = data
        checkCurrentStock()
        currentQuantity = "\(data.stock ?? 0)"
        alertMessage = "\(data.inventoryName ?? "") already returned by \(data.studentName ?? "")?"
        alertAction = changeToDone
        isShowAlert = true
    }
    
    @MainActor
    func changeToOnGoing() {
        if let currentRequest, let id = currentRequest.id {
            var request = currentRequest
            request.expiredAt = Calendar.current.date(byAdding: .day, value: 1, to: .now)
            request.status = "On Going"
            request.borrowedAt = .now
            
            database.collection("Peminjaman").document(id)
                .updateData(request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.resetCurrentRequestData()
                    }
                }
        }
    }
    
    @MainActor
    func changeToDone() {
        if let currentRequest, let id = currentRequest.id {
            var request = currentRequest
            request.status = "Done"
            request.returnedAt = .now
            
            database.collection("Peminjaman").document(id)
                .updateData(request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.addInventoryStock()
                    }
                }
        }
    }
    
    @MainActor
    private func addInventoryStock() {
        if let currentInventory, let id = currentInventory.id {
            var request = currentInventory
            request.stock += (Int(currentQuantity) ?? 0)
            
            database.collection("Inventaris").document(id)
                .updateData(request.toJSON()) { error in
                    if let error {
                        print(error)
                    } else {
                        self.resetCurrentRequestData()
                    }
                }
        }
    }
}
