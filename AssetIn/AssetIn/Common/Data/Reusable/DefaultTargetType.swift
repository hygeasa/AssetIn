//
//  DefaultTargetType.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation
import Moya

protocol DefaultTargetType: TargetType {
    var parameters: [String: Any] {
        get
    }
}

extension DefaultTargetType {
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8000/api") ?? (NSURL() as URL)
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        JSONEncoding.default
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
