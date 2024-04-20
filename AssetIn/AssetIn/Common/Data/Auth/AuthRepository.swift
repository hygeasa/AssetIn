//
//  AuthRepository.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation

protocol AuthRepository {
    func register(with body: RegisterBody) async -> Result<User, Error>
    func login(email: String, password: String) async -> Result<LoginResponse, Error>
    func logout() async -> Result<SuccessResponse, Error>
}

final class AuthDefaultRepository: AuthRepository {
    
    private let remote: AuthRemoteDataSource
    private let settings = SystemSettings.shared
    
    init(remote: AuthRemoteDataSource = AuthDefaultRemoteDataSource()) {
        self.remote = remote
    }
    
    func register(with body: RegisterBody) async -> Result<User, any Error> {
        do {
            let response = try await remote.register(with: body)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func login(email: String, password: String) async -> Result<LoginResponse, any Error> {
        do {
            let response = try await remote.login(email: email, password: password)
            DispatchQueue.main.async { [weak self] in
                self?.settings.accessToken = response.accessToken.orEmpty()
            }
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func logout() async -> Result<SuccessResponse, any Error> {
        do {
            let response = try await remote.logout()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
