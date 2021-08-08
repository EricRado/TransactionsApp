//
//  CreditViewModel.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import Foundation

struct CreditViewModel {
    let imageUrl: String?
    
    init(transaction: Transaction) {
        self.imageUrl = transaction.imageUrl
    }
}
