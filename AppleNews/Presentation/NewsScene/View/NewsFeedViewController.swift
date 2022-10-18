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
            tableView.reloadData()
        }
    }
    
    var imageDataTransferRepository: PosterImageRepositoryInterface
    
    init(viewModel: NewsFeedViewModelProtocol?, imageDataTransferRepository: PosterImageRepositoryInterface) {
        self.imageDataTransferRepository = imageDataTransferRepository
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
        setupTableView()
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "AppleNews"
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
    }
    
    private func bind() {
        viewModel?.items.observe(on: self) { [weak self] items in
            self?.newsItems = items
            self?.tableView.reloadData()
        }
    }
}

extension NewsFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.configure(model: newsItems[indexPath.row], imageDataReop: imageDataTransferRepository)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsTableViewCell.hegith
    }
    
}
