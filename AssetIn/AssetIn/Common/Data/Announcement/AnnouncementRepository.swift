//
//  AnnouncementRepository.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation

protocol AnnouncementRepository {
    func create(with body: Announcement) async -> Result<Announcement, Error>
    func getList() async -> Result<[Announcement], Error>
    func update(id: Int, field: Announcement) async -> Result<Announcement, Error>
    func delete(id: Int) async -> Result<SuccessResponse, Error>
}

final class AnnouncementDefaultRepository: AnnouncementRepository {
    
    private let remote: AnnouncementRemoteDataSource
    
    init(remote: AnnouncementRemoteDataSource = AnnouncementDefaultRemoteDataSource()) {
        self.remote = remote
    }
    
    func create(with body: Announcement) async -> Result<Announcement, any Error> {
        do {
            let response = try await remote.create(with: body)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func getList() async -> Result<[Announcement], any Error> {
        do {
            let response = try await remote.getList()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func update(id: Int, field: Announcement) async -> Result<Announcement, any Error> {
        do {
            let response = try await remote.update(id: id, field: field)
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
