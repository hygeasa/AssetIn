//
//  LoanTargetType.swift
//  AssetIn
//
//  Created by Irham Naufal on 21/04/24.
//

import Foundation
import Moya

enum LoanTargetType {
    case create(body: LoanRequest)
    case getUserLoanList(status: LoanStatus?)
    case homeGetUseLoanList
}

extension LoanTargetType: DefaultTargetType, AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
    
    var parameters: [String : Any] {
        switch self {
        case .create(let body):
            return body.toJSON()
        case .getUserLoanList(let status):
            return [
                "status" : (status?.rawValue).orEmpty()
            ]
        case .homeGetUseLoanList:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/loans"
        case .getUserLoanList:
            return "/loans/user"
        case .homeGetUseLoanList:
            return "/home-loans"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .getUserLoanList:
            return .get
        case .homeGetUseLoanList:
            return .get
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .create:
            return JSONEncoding.default
        case .getUserLoanList:
            return URLEncoding.queryString
        case .homeGetUseLoanList:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
