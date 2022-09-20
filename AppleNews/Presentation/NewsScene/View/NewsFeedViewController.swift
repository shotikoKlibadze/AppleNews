//
//  ViewController.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 01.09.22.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: view.bounds)
    private var viewModel: NewsFeedViewModelProtocol?
    
    private var newsItems = [NewsFeedItemViewModel]() {
        didSet {
            print(newsItems.count)
        }
    }
    
    init(with viewModel: NewsFeedViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        view.backgroundColor = .white
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "AppleNews"
    }
    
    private func bind() {
        viewModel?.items.observe(on: self) { [weak self] items in
            self?.newsItems = items
        }
    }
}
