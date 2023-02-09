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
    
    func configureCell(game: Game) {
        gameTitle.text = game.name ?? ""
        gameImg.load(urlString: game.backgroundImage)
        gameMetacritic.text = "\(game.metacritic ?? 0)"
        gameGenre.text = game.genres?.compactMap{ $0.name }.joined(separator: ", ")
    }
}
