//
//  NewsArticleDetailsViewController.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 18.10.22.
//

import UIKit

final class NewsArticleDetailsViewController : UIViewController {
    
    let article: NewsArticle
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(article: NewsArticle) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 200, left: 16, bottom: 200, right: 16))
    }
    
    private func setupData() {
        descriptionLabel.text = article.description
    }
                                    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
