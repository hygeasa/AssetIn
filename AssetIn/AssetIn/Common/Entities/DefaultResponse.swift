//
//  DefaultResponse.swift
//  NONTON ID
//
//  Created by Irham Naufal on 11/03/24.
//

import Foundation

struct ArrayResponse<Data: Codable>: Codable {
    var data: [Data]?
}

struct DataResponse<Data: Codable>: Codable {
    var data: Data?
}

struct SuccessResponse: Codable {
    var message: String?
}

struct ServerError: Codable, Error {
    let statusCode: Int?
    var message: String? = "Internal server error."
}
