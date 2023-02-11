//
//  DetailView.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import UIKit

class DetailView: UIViewController {
    //MARK: - Outlets
    @IBOutlet private var gradientView: UIView!
    @IBOutlet private var gameName: UILabel!
    @IBOutlet private var gameDesc: UILabel!
    @IBOutlet private var gameImage: UIImageView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var webiteBtn: UIButton!
    @IBOutlet private var redditBtn: UIButton!
    //MARK: - Properties
    var viewModel: GameDetailsViewModelType?
    private lazy var imageService: ImageServiceType = ImageService()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntialUI()
        viewModel?.fetchGameDetails()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: - Actions
    @objc
    func btnFavTapped(_ sender: AnyObject) {
        
    }
    
    @IBAction private func btnWebsite(sender: UIButton) {
        if let url = viewModel?.getWebsiteUrl() {
            UIApplication.shared.open(url)
        }
    }
    @IBAction private func btnReddit(sender: UIButton) {
        if let url = viewModel?.getRedditUrl() {
            UIApplication.shared.open(url)
        }
    }
    //MARK: - Private Methods
    private func setupIntialUI() {
        gradientView.addGradient(color1: .clear, color2: .black.withAlphaComponent(0.8))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(btnFavTapped))
        viewModel?.delegate = self
        self.contentView.isHidden = true
        self.activityIndicator.isHidden = false
        redditBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        redditBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

//MARK: - View Model Delegate
extension DetailView: GameDetailViewModelDelegate {
    func showError(error: NetworkRequestError) {
        DispatchQueue.main.async { [weak self] in
            error.showErrorDialog(viewController: self)
        }
    }
    
    func updateUI(with gameDetail: GameDetailModel) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.isHidden = false
            self?.activityIndicator.isHidden = true
            self?.gameName.text = gameDetail.name ?? ""
            self?.gameDesc.setHtmlText(html: gameDetail.description ?? "")
            guard let urlStr = gameDetail.backgroundImage else { return }
            guard let url = URL(string: urlStr) else { return }
            _ = self?.imageService.image(for: url) {[weak self] image in
                self?.gameImage.image = image
            }
        }
    }
    
    
}
