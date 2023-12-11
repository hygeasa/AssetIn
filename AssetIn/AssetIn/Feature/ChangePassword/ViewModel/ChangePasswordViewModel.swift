//
//  ChangePasswordViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 07/12/23.
//

import SwiftUI

class ChangePasswordViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var usernameText: String = ""
    @Published var NISText: String = ""
    @Published var passwordText: String = ""
    @Published var isRegister: Bool = false
    @Published var isChangeSuccess: Bool = false
}
