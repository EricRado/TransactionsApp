//
//  TransactionEndpoint.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

enum TransactionEndpoint {
    case transaction
}

extension TransactionEndpoint: EndpointConstructable {
    var path: String {
        switch self {
        case .transaction:
            return "/transactions-v1.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .transaction:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .transaction:
            return .request
        }
    }
}
