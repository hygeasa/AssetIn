//
//  InventoryRepository.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import Foundation

protocol InventoryRepository {
    func create(body: InventoryRequest) async -> Result<Inventory, Error>
    func getList(categoryId: CategoryType) async -> Result<[Inventory], Error>
    func update(id: Int, body: InventoryRequest) async -> Result<Inventory, Error>
    func delete(id: Int) async -> Result<SuccessResponse, Error>
}

final class InventoryDefaultRepository: InventoryRepository {
    
    private let remote: InventoryRemoteDataSource
    
    init(remote: InventoryRemoteDataSource = InventoryDefaultRemoteDataSource()) {
        self.remote = remote
    }
    
    func create(body: InventoryRequest) async -> Result<Inventory, any Error> {
        do {
            let response = try await remote.create(body: body)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func getList(categoryId: CategoryType) async -> Result<[Inventory], any Error> {
        do {
            let response = try await remote.getList(categoryId: categoryId.rawValue)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func update(id: Int, body: InventoryRequest) async -> Result<Inventory, any Error> {
        do {
            let response = try await remote.update(id: id, body: body)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func delete(id: Int) async -> Result<SuccessResponse, any Error> {
        do {
            let response = try await remote.delete(id: id)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
