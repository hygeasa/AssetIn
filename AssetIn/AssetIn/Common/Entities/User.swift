//
//  User.swift
//  AssetIn
//
//  Created by Hygea Saveria on 19/12/23.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int?
    var name: String?
    var email: String?
    var avatar: String?
    var role: String?
    var status: String?
    var nis: String?
    var nip: String?
}

struct RegisterBody: Codable {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
    var role: String
    var nip: String?
    var nis: String?
    
    enum CodingKeys: String, CodingKey {
        case name, email, password, role, nip, nis
        case passwordConfirmation = "password_confirmation"
    }
}

struct LoginResponse: Codable {
    var accessToken: String?
    var tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
