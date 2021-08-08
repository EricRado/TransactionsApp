//
//  CreditView.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import UIKit

final class CreditView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        activityIndicator.style = .medium
        return activityIndicator
    }()
    
    var viewModel: CreditViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            activityIndicator.startAnimating()
            imageView.loadImage(from: viewModel.imageUrl) { [weak self] isSuccessful in
                self?.activityIndicator.stopAnimating()
                if !isSuccessful {
                    self?.imageView.image = UIImage(named: "NoImageFound")
                }
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0.5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 75),
            activityIndicator.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}
