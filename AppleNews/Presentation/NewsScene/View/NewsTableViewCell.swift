//
//  NewsTableViewCell.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    static let hegith: GLfixed = 350
    
    let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage(systemName: "homekit")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tittleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLaout()
    }
    
    private func setupLaout() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            tittleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        stackView.addArrangedSubviews([posterImageView,tittleLabel,descriptionLabel])
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 10, right: 16))
    }
    
    func configure(model: NewsFeedItemViewModel) {
        tittleLabel.text = model.title
        descriptionLabel.text = model.limitedOverview
        
        guard let imageURL = model.posterImage, let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }.resume()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        descriptionLabel.text = nil
        tittleLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
