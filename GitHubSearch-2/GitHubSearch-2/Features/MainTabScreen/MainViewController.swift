//
//  MainTabViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
    }
}
