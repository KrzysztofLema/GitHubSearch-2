//
//  BasicView.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 26/05/2024.
//

import UIKit

open class BasicView: UIView {
    
    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable,
                message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open func addSubviews() {}
    
    open func setupConstraints() {}
    
    open func setupSubviews() {}
}
