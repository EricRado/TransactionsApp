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
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var sortBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonTapped))
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
        navigationItem.rightBarButtonItem = sortBarButtonItem
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func sortButtonTapped() {
        let alertController = UIAlertController(title: "Sort Transaction By", message: nil, preferredStyle: .actionSheet)
        
        for state in TransactionSortState.allCases {
            alertController.addAction(UIAlertAction(title: state.rawValue, style: .default, handler: { _ in
                self.transactionListViewModel.sort(by: state)
            }))
        }
        alertController.addAction(UIAlertAction(title: "CANCEL", style: .destructive, handler: nil))
        
        present(alertController, animated: true, completion: nil)
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

extension TransactionListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transaction = transactionListViewModel.transactions[indexPath.item]
        let detailViewController = TransactionDetailViewController(transaction: transaction)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
