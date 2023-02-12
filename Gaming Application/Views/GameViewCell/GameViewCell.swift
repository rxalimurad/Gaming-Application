//
//  GameViewCell.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class GameViewCell: UITableViewCell {
    // MARK: - Properties
    private lazy var imageService: ImageServiceType = ImageService()
    private var imageRequest: Cancellable?
    // MARK: - Outlets
    @IBOutlet private var gameImg: UIImageView!
    @IBOutlet private var gameTitle: UILabel!
    @IBOutlet private var gameMetacritic: UILabel!
    @IBOutlet private var gameGenre: UILabel!
    // MARK: - Methods
    func configureCell(game: Game, rememberOpenGame: Bool = true) {
        gameTitle.text = game.name ?? ""
        gameMetacritic.text = "\(game.metacritic ?? 0)"
        gameGenre.text = game.genres?.compactMap { $0.name }.joined(separator: ", ")
        if let gameId = game.id, rememberOpenGame {
            self.backgroundColor = UserDefaults.standard.openedGames.contains(gameId) ?
            UIColor.openedColor : UIColor.white
        }
        guard let urlStr = game.backgroundImage else { return }
        guard let url = URL(string: urlStr) else { return }
        imageRequest = imageService.image(for: url) {[weak self] image in
            self?.gameImg.image = image
        }
    }
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImg.image = nil
        imageRequest?.cancel()
    }
}
