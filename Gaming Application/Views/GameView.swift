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
    
    private func moveToDetails(with gameId: Int) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailView
        vc.viewModel = GameDetailsViewModel(gameId: gameId, service: GameService())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - View Model Delegate
extension GameView: GameViewModelDelegate {
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
        if let gameId = viewModel.getGame(at: indexPath)?.id {
            self.moveToDetails(with: gameId)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        viewModel.hitInProgress ? 50 : 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        footerView.addSubview(spinner)
        spinner.setConstraints(with: footerView)
        footerView.backgroundColor = .clear
        return footerView
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
                viewModel.getGamesList(search: nil)
            }
        }
        
    }
}
