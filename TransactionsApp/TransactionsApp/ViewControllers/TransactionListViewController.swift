//
//  TransactionListViewController.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import UIKit

final class TransactionListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 60)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            TransactionCell.self,
            forCellWithReuseIdentifier: TransactionCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let transactionListViewModel: TransactionListViewModel
    
    init() {
        self.transactionListViewModel = TransactionListViewModel(networkManager: NetworkManager())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        self.transactionListViewModel.reloadCollectionViewHandler = {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
        
        self.transactionListViewModel.getTransactions()
    }
    
    private func setupView() {
        navigationItem.title = "Transactions"
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TransactionListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactionListViewModel.transactionCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = transactionListViewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
}
