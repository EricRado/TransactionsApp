//
//  TransactionCellViewModel.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import UIKit

struct TransactionCellViewModel {
    let description: NSAttributedString
    let date: NSAttributedString
    let amount: NSAttributedString
    
    init(transaction: Transaction) {
        self.description = NSAttributedString(
            string: transaction.description,
            attributes: [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)
            ])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.date = NSAttributedString(
            string: dateFormatter.string(from: transaction.date),
            attributes: [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2),
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
        
        self.amount = NSAttributedString(
            string: "$\(transaction.amount)",
            attributes: [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote),
                NSAttributedString.Key.foregroundColor: transaction.isCredit ? UIColor.green : UIColor.red
            ])
    }
}
