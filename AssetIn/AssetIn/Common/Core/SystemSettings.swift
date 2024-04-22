//
//  SystemSettings.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation

enum SystemKey {
    static let accessToken = "auth.accessToken"
    static let role = "auth.role"
}

final class SystemSettings: ObservableObject {
    static let shared = SystemSettings()
    
    private let defaults = UserDefaults.standard
    
    @Published var mainTabSelection = MainTabSelection.home
    
    @Published var accessToken: String {
        didSet {
            defaults.set(accessToken, forKey: SystemKey.accessToken)
        }
    }
    
    @Published var role: String {
        didSet {
            defaults.set(role, forKey: SystemKey.role)
        }
    }
    
    init() {
        self.accessToken = self.defaults.string(forKey: SystemKey.accessToken).orEmpty()
        self.role = self.defaults.string(forKey: SystemKey.role).orEmpty()
    }
}

extension SystemSettings {
    var isActive: Bool {
        !accessToken.isEmpty && !role.isEmpty
    }
    
    var isStudent: Bool {
        return role == "siswa"
    }
    
    var isAdmin: Bool {
        return role == "admin"
    }
    
    var isSuperAdmin: Bool {
        return role == "superadmin"
    }
}

enum MainTabSelection {
    case home
    case profile
}
