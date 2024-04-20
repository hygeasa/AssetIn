//
//  AuthRemoteDataSource.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation
import Moya

protocol AuthRemoteDataSource {
    func register(with body: RegisterBody) async throws -> User
    func login(email: String, password: String) async throws -> LoginResponse
    func logout() async throws -> SuccessResponse
}

final class AuthDefaultRemoteDataSource: AuthRemoteDataSource {
    
    private let provider: MoyaProvider<AuthTargetType>
    
    init(provider: MoyaProvider<AuthTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func register(with body: RegisterBody) async throws -> User {
        try await provider.requestAsync(.register(body), model: User.self)
    }
    
    func login(email: String, password: String) async throws -> LoginResponse {
        try await provider.requestAsync(.login(email: email, password: password), model: LoginResponse.self)
    }
    
    func logout() async throws -> SuccessResponse {
        try await provider.requestAsync(.logout, model: SuccessResponse.self)
    }
}
