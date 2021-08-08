//
//  DebitViewModel.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import UIKit

struct DebitViewModel {
    private let id: Int
    private let description: String
    let date: NSAttributedString
    let amount: NSAttributedString
    var note: String?
    
    init(transaction: Transaction) {
        self.id = transaction.id
        self.description = transaction.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.date = NSAttributedString(
            string: "Date : \(dateFormatter.string(from: transaction.date))",
            attributes: [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body),
            ])
        
        self.amount = NSAttributedString(
            string: "Amount : $\(transaction.amount)",
            attributes: [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body),
            ])
        
        self.note = loadNote(description: transaction.description, id: transaction.id)
    }
    
    private func loadNote(description: String, id: Int) -> String? {
        return UserDefaults.standard.string(forKey: "\(description)-\(id)")
    }
    
    mutating func saveNote(with text: String) {
        self.note = text
        UserDefaults.standard.setValue(text, forKey: "\(description)-\(id)")
    }
}
