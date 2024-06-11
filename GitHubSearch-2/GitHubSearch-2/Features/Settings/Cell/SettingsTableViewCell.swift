//
//  SettingsViewCell.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 11/06/2024.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    struct Constants {
        static let containerViewEdgesInsets: UIEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
    }
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        setupSubviews()
    }
    
    func configure(with settingsOption: SettingsOption) {
        selectionStyle = .none
        
        titleLabel.text = settingsOption.title
        titleLabel.textColor = settingsOption.titleTextColor
        
        iconImageView.image = settingsOption.icon
        iconImageView.tintColor = settingsOption.imageTintColor
        iconImageView.contentMode = .scaleAspectFit
        
        containerView.backgroundColor = settingsOption.backgroundColor
    }
    
    private func addSubviews() {
        [containerView].forEach(addSubview(_:))
        
        [iconImageView, titleLabel].forEach(containerView.addSubview(_:))
    }
    
    private func setupConstraints() {
        containerView.edgesToSuperview(insets: Constants.containerViewEdgesInsets)

        iconImageView.trailingToLeading(of: titleLabel)
        iconImageView.centerYToSuperview()
        iconImageView.size(UIConstants.defaultImageSize)
        
        titleLabel.centerInSuperview()
    }
    
    private func setupSubviews() {
        containerView.layer.cornerRadius = UIConstants.defaultCornerRadius
    }
}
