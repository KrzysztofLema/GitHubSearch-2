//
//  Footer.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import UIKit

final class FooterStackView: UIStackView {
    
    @Injected(\.languageColorStore) private var languageColorStore: LanguageColorsStoreType
    
    private var languageColorView = UIView()
    private let footerLabel = UILabel()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setupView()
    }
    
    private func addSubviews() {
        [languageColorView,
         footerLabel
        ].forEach(addArrangedSubview(_:))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        languageColorView.asCircle()
        languageColorView.layer.borderColor = Color.blackBorderColor.cgColor
        languageColorView.layer.borderWidth = 0.5
    }
    
    private func setupView() {
        spacing = UIConstants.defaultSpacing
        
        languageColorView.widthToHeight(of: self)
        languageColorView.isHidden = true
        
        footerLabel.font = .systemFont(ofSize: 13)
        footerLabel.textColor = .lightGray
    }
    
    public func setupFooter(for itemViewModel: ItemViewModel) {
        let shouldShowSeparator = !itemViewModel.item.language.isNilOrEmpty
        
        if let languageColor = languageColorStore.getColor(for: itemViewModel.item.language ?? "") {
            languageColorView.backgroundColor = languageColor
            languageColorView.isHidden = false
        }
        
        footerLabel.attributedText = FooterRepositoryTextBuilder()
            .with(text: itemViewModel.item.language)
            .with(shouldShowSeparatorAtBeginning: shouldShowSeparator)
            .with(image: UIImage(systemName: "star"), text: itemViewModel.stargazers)
            .withSeparator()
            .with(text: itemViewModel.updatedAtText)
            .build()
    }
    
    public func setupFooterForReuse() {
        languageColorView.backgroundColor = nil
        languageColorView.isHidden = true
    }
}
