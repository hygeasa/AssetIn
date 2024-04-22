//
//  InventoryTargetType.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import Foundation
import Moya

enum InventoryTargetType {
    case create(body: InventoryRequest)
    case getList(categoryId: Int)
    case update(id: Int, body: InventoryRequest)
    case delete(id: Int)
}

extension InventoryTargetType: DefaultTargetType, AccessTokenAuthorizable {
    
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
    
    var parameters: [String : Any] {
        switch self {
        case .create(let body):
            return body.toJSON()
        case .update(_, let body):
            return body.toJSON()
        case .getList(let categoryId):
            return ["category_id" : categoryId]
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/inventories"
        case .getList:
            return "/inventories"
        case .update(let id, _):
            return "/inventories/\(id)"
        case .delete(let id):
            return "/inventories/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .getList:
            return .get
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .create, .update:
            return JSONEncoding.default
        case .getList:
            return URLEncoding.queryString
        case .delete:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
