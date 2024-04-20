//
//  AuthTargetType.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation
import Moya

enum AuthTargetType {
    case register(RegisterBody)
    case login(email: String, password: String)
    case logout
}

extension AuthTargetType: DefaultTargetType, AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        case .logout:
            return .bearer
        default:
            return .none
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .register(let body):
            return body.toJSON()
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .logout:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .logout:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
