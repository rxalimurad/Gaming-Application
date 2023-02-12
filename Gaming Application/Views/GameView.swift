//
//  ViewController.swift
//  Gaming Application
//
//  Created by Ali Murad on 09/02/2023.
//

import UIKit

class GameView: UIViewController {
    //MARK: - Properties
    var viewModel: GameViewModelType = GameViewModel(service: GameService())
    //MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var nrfView: UIView!
    @IBOutlet private var searchBar: UISearchBar!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntialUI()
        viewModel.getGamesList(search: nil)
    }
    
    //MARK: - Private Methods
    private func setupIntialUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: Constants.CellID.gameViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellID.gameViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        nrfView.isHidden = false
        viewModel.delegate = self
    }
    
    private func moveToDetails(with game: Game) {
        guard let gameId = game.id else { return }
        UserDefaults.standard.openedGames.append(gameId)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let vc = UIStoryboard(name: Constants.Views.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: Constants.Views.DetailView) as! DetailView
        //setting view model for next screen
        vc.viewModel = GameDetailsViewModel(game: game, service: GameService(), localDBHandler: CoreDataHandler())
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.reloadData()
    }
    private func getTableFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        footerView.addSubview(spinner)
        spinner.setConstraints(with: footerView)
        footerView.backgroundColor = .clear
        return footerView
    }
}

//MARK: - View Model Delegate
extension GameView: GameViewModelDelegate {
    func updateTableFooter(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.tableFooterView = isHidden ? nil : self?.getTableFooter()
        }
    }
    
    func showError(error: NetworkRequestError) {
        DispatchQueue.main.async { [weak self] in
            error.showErrorDialog(viewController: self)
        }
    }
    
    func updateUI(games: [Game]?) {
        DispatchQueue.main.async {[weak self] in
            self?.nrfView.isHidden = games?.isEmpty == false
            self?.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate n DataSource
extension GameView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getGamesListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.gameViewCell, for: indexPath) as? GameViewCell {
            if let game = viewModel.getGame(at: indexPath) {
                cell.configureCell(game: game)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let game = viewModel.getGame(at: indexPath) {
            self.moveToDetails(with: game)
        }
    }
   
    
}
//MARK: - Search Bar Delegate
extension GameView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchText.count > 3 {
            viewModel.searchString = searchText
            viewModel.getGamesList(search: viewModel.searchString)
        }
    }
}


//MARK: - TableView ScrollView
extension GameView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let yaxis = offset.y + bounds.size.height - inset.bottom
        let height = size.height
        let reloaddistance: CGFloat = 50
        if yaxis > height && yaxis < (height + reloaddistance) {
            if scrollView.isDragging && !viewModel.hitInProgress {
                viewModel.pageNumber += 1
                viewModel.getGamesList(search: viewModel.searchString)
            }
        }
        
    }
}
