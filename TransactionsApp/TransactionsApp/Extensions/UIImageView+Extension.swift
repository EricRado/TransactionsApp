//
//  UIImageView+Extension.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String?, networkManager: NetworkManager = NetworkManager(), completion: @escaping (Bool) -> ()) {
        guard let url = url else {
            completion(false)
            return
        }
        
        networkManager.requestImage(url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    completion(false)
                case .success(let data):
                    self?.image = UIImage(data: data)
                    completion(true)
                }
            }
        }
    }
}
