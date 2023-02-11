//
//  GameViewCell.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class GameViewCell: UITableViewCell {
    @IBOutlet private var gameImg: UIImageView!
    @IBOutlet private var gameTitle: UILabel!
    @IBOutlet private var gameMetacritic: UILabel!
    @IBOutlet private var gameGenre: UILabel!
    private lazy var imageService: ImageServiceType = ImageService()
    private var imageRequest: Cancellable?


    func configureCell(game: Game) {
        gameTitle.text = game.name ?? ""
        gameMetacritic.text = "\(game.metacritic ?? 0)"
        gameGenre.text = game.genres?.compactMap{ $0.name }.joined(separator: ", ")
        guard let urlStr = game.backgroundImage else { return }
        guard let url = URL(string: urlStr) else { return }
        imageRequest = imageService.image(for: url) {[weak self] image in
            self?.gameImg.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImg.image = nil
        imageRequest?.cancel()
    }
}
