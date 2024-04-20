//
//  AnnouncementRemoteDataSource.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation
import Moya

protocol AnnouncementRemoteDataSource {
    func create(with body: Announcement) async throws -> Announcement
    func getList() async throws -> [Announcement]
    func update(id: Int, field: Announcement) async throws -> Announcement
    func delete(id: Int) async throws -> SuccessResponse
}

final class AnnouncementDefaultRemoteDataSource: AnnouncementRemoteDataSource {
    
    private let provider: MoyaProvider<AnnouncementTargetType>
    
    init(provider: MoyaProvider<AnnouncementTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func create(with body: Announcement) async throws -> Announcement {
        try await provider.requestAsync(.create(body), model: Announcement.self)
    }
    
    func getList() async throws -> [Announcement] {
        try await provider.requestAsync(.getList, model: [Announcement].self)
    }
    
    func update(id: Int, field: Announcement) async throws -> Announcement {
        try await provider.requestAsync(.update(id: id, field: field), model: Announcement.self)
    }
    
    func delete(id: Int) async throws -> SuccessResponse {
        try await provider.requestAsync(.delete(id: id), model: SuccessResponse.self)
    }
}
