//
//  LoanRemoteDataSource.swift
//  AssetIn
//
//  Created by Irham Naufal on 21/04/24.
//

import Foundation
import Moya

protocol LoanRemoteDataSource {
    func create(body: LoanRequest) async throws -> Loan
    func getUserLoanList(status: LoanStatus?) async throws -> [Loan]
    func homeGetUseLoanList() async throws -> [Loan]
}

final class LoanDefaultRemoteDataSource: LoanRemoteDataSource {
    
    private let provider: MoyaProvider<LoanTargetType>
    
    init(provider: MoyaProvider<LoanTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func create(body: LoanRequest) async throws -> Loan {
        try await provider.requestAsync(.create(body: body), model: Loan.self)
    }
    
    func getUserLoanList(status: LoanStatus?) async throws -> [Loan] {
        try await provider.requestAsync(.getUserLoanList(status: status), model: [Loan].self)
    }
    
    func homeGetUseLoanList() async throws -> [Loan] {
        try await provider.requestAsync(.homeGetUseLoanList, model: [Loan].self)
    }
}
