//
//  LoanRepository.swift
//  AssetIn
//
//  Created by Irham Naufal on 21/04/24.
//

import Foundation

protocol LoanRepository {
    func create(body: LoanRequest) async -> Result<Loan, Error>
    func getUserLoanList(status: LoanStatus?) async -> Result<[Loan], Error>
    func homeGetUseLoanList() async -> Result<[Loan], Error>
}

final class LoanDefaultRepository: LoanRepository {
    
    private let remote: LoanRemoteDataSource
    
    init(remote: LoanRemoteDataSource = LoanDefaultRemoteDataSource()) {
        self.remote = remote
    }
    
    func create(body: LoanRequest) async -> Result<Loan, any Error> {
        do {
            let response = try await remote.create(body: body)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func getUserLoanList(status: LoanStatus?) async -> Result<[Loan], any Error> {
        do {
            let response = try await remote.getUserLoanList(status: status)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func homeGetUseLoanList() async -> Result<[Loan], any Error> {
        do {
            let response = try await remote.homeGetUseLoanList()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
