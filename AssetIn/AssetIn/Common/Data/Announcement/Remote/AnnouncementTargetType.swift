//
//  AnnouncementTargetType.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation
import Moya

enum AnnouncementTargetType {
    case create(Announcement)
    case getList
    case update(id: Int, field: Announcement)
    case delete(id: Int)
}

extension AnnouncementTargetType: DefaultTargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType? {
        return .none
    }
    
    var parameters: [String : Any] {
        switch self {
        case .create(let body):
            return body.toJSON()
        case .update(_, let field):
            return field.toJSON()
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .create, .getList:
            return "/articles"
        case .update(let id, _):
            return "articles/\(id)"
        case .delete(let id):
            return "articles/\(id)"
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
        case .delete, .getList:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
