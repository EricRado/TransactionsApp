//
//  TransactionListViewModel.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

final class TransactionListViewModel {
    private let networkManager: NetworkManager
    private var transactions = [Transaction]()
    private(set) var transactionCellViewModels = [TransactionCellViewModel]()
    
    var reloadCollectionViewHandler: (() -> ())?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTransactions() {
        let completion: (Result<TransactionListDTO, Error>) -> () = { [weak self] result in
            switch result {
            case .success(let transctionDTOs):
                let transactions = transctionDTOs.transactions.map { Transaction(dto: $0) }
                self?.transactions = transactions
                self?.transactionCellViewModels = transactions.map { TransactionCellViewModel(transaction: $0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.reloadCollectionViewHandler?()
        }
        
        networkManager.request(TransactionEndpoint.transaction, completion: completion)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> TransactionCellViewModel {
        return self.transactionCellViewModels[indexPath.item]
    }
}
