//
//  UIImageView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit
extension UIImageView {
    func load(urlString: String?) {
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
