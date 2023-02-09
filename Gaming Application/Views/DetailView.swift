//
//  DetailView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class DetailView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(addTapped))

    }
    @objc
    func addTapped(_ sender: AnyObject) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

}
