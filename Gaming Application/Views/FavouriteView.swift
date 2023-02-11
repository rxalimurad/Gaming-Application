//
//  FavouriteView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class FavouriteView: UIViewController {
    //MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var nrfView: UIView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntialUI()
    }
    
    
    //MARK: - Private Methods
    private func setupIntialUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: Constants.CellID.gameViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellID.gameViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        nrfView.isHidden = false
//        viewModel.delegate = self
    }
}

extension FavouriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.CellID.gameViewCell, for: indexPath)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
