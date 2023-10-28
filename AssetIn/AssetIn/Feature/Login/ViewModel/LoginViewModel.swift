//
//  LoginViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
}
