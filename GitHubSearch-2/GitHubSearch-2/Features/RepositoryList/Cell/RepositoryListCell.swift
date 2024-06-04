//
//  RepositoryListCell.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 30/05/2024.
//

import UIKit

final class RepositoryListCell: UICollectionViewCell {
        
    private let containerView = UIView()
    private let repositoryContainerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let titleStackView = UIStackView()
    private let footerStackView = FooterStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(repositoryContainerView)
        
        repositoryContainerView.addSubview(titleStackView)
        
        [imageView, titleLabel].forEach(titleStackView.addArrangedSubview(_:))
        
        repositoryContainerView.addSubview(descriptionLabel)
        repositoryContainerView.addSubview(footerStackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        footerStackView.setupFooterForReuse()
    }
    
    private func setupConstraints() {
        containerView.edgesToSuperview()
        
        repositoryContainerView.edgesToSuperview(insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        titleStackView.edgesToSuperview(excluding: .bottom)
        
        imageView.height(24)
        imageView.width(24)
        
        descriptionLabel.topToBottom(of: titleStackView)
        descriptionLabel.leadingToSuperview()
        descriptionLabel.trailingToSuperview()
        
        footerStackView.edgesToSuperview(excluding: [.top])
        footerStackView.topToBottom(of: descriptionLabel, relation: .equalOrGreater)
        footerStackView.height(15)
    }
    
    private func setupSubviews() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 12
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        
        titleStackView.axis = .horizontal
        titleStackView.alignment = .center
        titleStackView.spacing = 3
        
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        descriptionLabel.numberOfLines = 4
        descriptionLabel.textAlignment = .justified
        descriptionLabel.font = .systemFont(ofSize: 15)
    }
    
    public func configure(with itemViewModel: ItemViewModel) {
        titleLabel.text = itemViewModel.item.fullName
        
        descriptionLabel.text = itemViewModel.item.description
        
        footerStackView.setupFooter(for: itemViewModel)
    }
}
