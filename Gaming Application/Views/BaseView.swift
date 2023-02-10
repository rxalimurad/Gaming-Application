//
//  BaseView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class BaseView: UIViewController {
    //MARK: - Properties
    var viewModel: GameViewModelType = GameViewModel(service: GameService())
    //MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var nrfView: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: Constants.CellID.gameViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellID.gameViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        nrfView.isHidden = false
        viewModel.delegate = self
        viewModel.getGamesList(search: nil)
    }
}
//MARK: - View Model Delegate
extension BaseView: GameViewModelDelegate {
    func updateUI(games: [Game]?) {
        DispatchQueue.main.async {[weak self] in
            self?.nrfView.isHidden = games?.isEmpty == false
            self?.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate n DataSource
extension BaseView: UITableViewDelegate, UITableViewDataSource {
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        viewModel.hitInProgress ? 50 : 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        footerView.addSubview(spinner)
        spinner.frame.origin = footerView.frame.origin
        footerView.backgroundColor = .red
        return footerView
    }
    
}
//MARK: - TableView ScrollView

extension BaseView {
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
