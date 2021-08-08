//
//  EndpointConstructable.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

protocol EndpointConstructable {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
}

extension EndpointConstructable {
    var baseUrl: String {
        return "https://m1-technical-assessment-data.netlify.app"
    }
}
