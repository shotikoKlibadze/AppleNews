//
//  NewsTableViewCell.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    static let hegith: CGFloat = 350
    
    let posterImageView : UIImageView = {
        let imageView = UIImageView()
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
    
    private var posterImageRepositoryInterface: PosterImageRepositoryInterface?
    private var viewModel: NewsFeedItemViewModel!
    private var imageLoadTask: Cancallable? { willSet { imageLoadTask?.cancel()} }
    
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
        stackView.fillSuperview(padding: .init(top: 5, left: 16, bottom: 0, right: 16))
    }
    
    func configure(model: NewsFeedItemViewModel, imageDataReop: PosterImageRepositoryInterface) {
        self.viewModel = model
        self.posterImageRepositoryInterface = imageDataReop
        tittleLabel.text = model.title
        descriptionLabel.text = model.limitedOverview
        updateImageView()
    }
    
    private func updateImageView() {
        guard let imageURLString = viewModel.posterImage else { return }
        imageLoadTask = posterImageRepositoryInterface?.fetchPoster(imageURLString: imageURLString, completion: { [weak self] imageData in
            self?.posterImageView.image = UIImage(data: imageData)

            self?.imageLoadTask = nil
        })
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
