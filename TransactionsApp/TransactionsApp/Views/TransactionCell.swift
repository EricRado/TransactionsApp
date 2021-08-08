//
//  TransactionCell.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import UIKit

final class TransactionCell: UICollectionViewCell {
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: TransactionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            descriptionLabel.attributedText = viewModel.description
            dateLabel.attributedText = viewModel.date
            amountLabel.attributedText = viewModel.amount
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.attributedText = nil
        dateLabel.attributedText = nil
        amountLabel.attributedText = nil
    }
    
    private func setupView() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
        
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 3)
        ])
        
        addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .lightGray
        addSubview(dividerView)
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
