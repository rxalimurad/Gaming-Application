//
//  ImageService.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import UIKit

protocol ImageServiceType {
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable
}

final class ImageService: ImageServiceType {
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            var image: UIImage?
            defer {
                // Execute Handler on Main Thread
                DispatchQueue.main.async {
                    // Execute Handler
                    completion(image)
                }
            }
            if let data = data {
                // Create Image from Data
                image = UIImage(data: data)
            }
        }
        // Resume Data Task
        dataTask.resume()
        return dataTask
    }
}
