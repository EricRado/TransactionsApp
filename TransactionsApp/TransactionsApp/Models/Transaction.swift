//
//  Transaction.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

struct Transaction {
    let id: Int
    let date: Date
    let amount: Double
    let isCredit: Bool
    let description: String
    let imageUrl: String?
    
    init(dto: TransactionDTO) {
        self.id = dto.id ?? 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'hh:mm:ssZ"
        self.date = dateFormatter.date(from: dto.date ?? "") ?? Date()
        
        self.amount = dto.amount ?? 0.0
        self.isCredit = dto.isCredit ?? false
        self.description = dto.description ?? ""
        self.imageUrl = dto.imageUrl
    }
}
