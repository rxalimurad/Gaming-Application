//
//  FavouriteView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class FavouriteView: UIViewController {
    // MARK: - Properties
    let viewModel = FavouriteViewModel(localDBHandler: CoreDataHandler())
    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var nrfView: UIView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntialUI()
        viewModel.fetchFavGameList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavGameList()
        reloadData()
    }

    // MARK: - Private Methods
    private func setupIntialUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: Constants.CellID.gameViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellID.gameViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        nrfView.isHidden = false
    }
    private func showAlert(completion: @escaping(() -> Void)) {
        let alert = UIAlertController(title: "Delete",
                                      message: "Are you sure you want to delete?",
                                      preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .default)
        let okBtn = UIAlertAction(title: "OK", style: .destructive) {_ in
            completion()
        }

        alert.addAction(okBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true)

    }
    private func moveToDetails(with game: Game) {
        guard let gameId = game.id else { return }
        UserDefaults.standard.openedGames.append(gameId)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        if let viewc = UIStoryboard(name: Constants.Views.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: Constants.Views.DetailView) as? DetailView {
            // setting view model for next screen
            viewc.viewModel = GameDetailsViewModel(game: game,
                                                   service: GameService(),
                                                   localDBHandler: CoreDataHandler())
            self.navigationController?.pushViewController(viewc, animated: true)
            self.tableView.reloadData()
        }
    }
}
// MARK: - TableView Delegate
extension FavouriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.gameViewCell,
                                                    for: indexPath) as? GameViewCell {
            cell.configureCell(game: viewModel.getFavGame(at: indexPath), rememberOpenGame: false)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfGames()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = viewModel.getFavGame(at: indexPath)
        self.moveToDetails(with: game)
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert {
                self.viewModel.removeFav(from: indexPath)
                self.nrfView.isHidden = self.viewModel.getNumberOfGames() != 0
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

// MARK: - ViewModel Delegate
extension FavouriteView: FavouriteViewModelDelegate {
    func reloadData() {
        self.nrfView.isHidden = viewModel.getNumberOfGames() != 0
        self.tableView.reloadData()
    }
}
