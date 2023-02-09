//
//  BaseView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class BaseView: UIViewController {
    //MARK: - Properties
    var tableViewData: GameListModel = .new {
        didSet {
            nrfView.isHidden = tableViewData.results?.isEmpty == false
            self.tableView.reloadData()
        }
    }
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
    }
}
//MARK: - TableView Delegate n DataSource
extension BaseView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.gameViewCell, for: indexPath) as? GameViewCell {
            if let game = tableViewData.results?[indexPath.row] {
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
    
    
}
