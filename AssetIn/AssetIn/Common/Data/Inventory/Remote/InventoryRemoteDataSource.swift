//
//  InventoryRemoteDataSource.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import Foundation
import Moya

protocol InventoryRemoteDataSource {
    func create(body: InventoryRequest) async throws -> Inventory
    func getList(categoryId: Int) async throws -> [Inventory]
    func update(id: Int, body: InventoryRequest) async throws -> Inventory
    func delete(id: Int) async throws -> SuccessResponse
}

final class InventoryDefaultRemoteDataSource: InventoryRemoteDataSource {
    
    private let provider: MoyaProvider<InventoryTargetType>
    
    init(provider: MoyaProvider<InventoryTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func create(body: InventoryRequest) async throws -> Inventory {
        try await provider.requestAsync(.create(body: body), model: Inventory.self)
    }
    
    func getList(categoryId: Int) async throws -> [Inventory] {
        try await provider.requestAsync(.getList(categoryId: categoryId), model: [Inventory].self)
    }
    
    func update(id: Int, body: InventoryRequest) async throws -> Inventory {
        try await provider.requestAsync(.update(id: id, body: body), model: Inventory.self)
    }
    
    func delete(id: Int) async throws -> SuccessResponse {
        try await provider.requestAsync(.delete(id: id), model: SuccessResponse.self)
    }
}
