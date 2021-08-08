//
//  TransactionDetailViewController.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import UIKit

final class TransactionDetailViewController: UIViewController {
    private let isCredit: Bool
    private var debitViewModel: DebitViewModel?
    private var creditViewModel: CreditViewModel?
    
    init(transaction: Transaction) {
        self.isCredit = transaction.isCredit
        if isCredit {
            self.creditViewModel = CreditViewModel(transaction: transaction)
        } else {
            self.debitViewModel = DebitViewModel(transaction: transaction)
        }
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = transaction.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let detailView: UIView
        
        if isCredit {
            let creditView = CreditView()
            creditView.translatesAutoresizingMaskIntoConstraints = false
            creditView.viewModel = creditViewModel
            
            detailView = creditView
        } else {
            let debitView = DebitView()
            debitView.translatesAutoresizingMaskIntoConstraints = false
            debitView.viewModel = debitViewModel
            
            detailView = debitView
        }
        
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }

}
