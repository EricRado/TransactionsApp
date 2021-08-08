//
//  TransactionDTO.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

struct TransactionListDTO: Decodable {
    let transactions: [TransactionDTO]
}

struct TransactionDTO: Decodable {
    let id: Int?
    let date: String?
    let amount: Double?
    let isCredit: Bool?
    let description: String?
    let imageUrl: String?
}
