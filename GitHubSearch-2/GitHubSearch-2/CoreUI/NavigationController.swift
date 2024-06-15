//
//  NavigationController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 27/05/2024.
//

import UIKit

public class NavigationController: UINavigationController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(
        *,
        unavailable,
        message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(
        *,
        unavailable,
        message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
