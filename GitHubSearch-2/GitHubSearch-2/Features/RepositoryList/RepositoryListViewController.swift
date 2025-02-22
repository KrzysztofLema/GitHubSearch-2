//
//  RepositoryListViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import Combine
import GHSCoreUI
import GHSModels
import UIKit

protocol RepositoryListViewControllerDelegate: AnyObject {
    func repositoryListViewController(_ repositoryListViewController: RepositoryListViewController, didSelect: Item)
}

final class RepositoryListViewController: BasicViewController {
    public weak var delegate: RepositoryListViewControllerDelegate?

    private let viewModel: RepositoryListViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = RepositoryListView(viewModel: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repository Search"
        (view as? RepositoryListView)?.delegate = self

        setupSearchViewController(with: viewModel)
    }

    private func setupSearchViewController(with viewModel: RepositoryListViewModel) {
        let searchController = ObservableUISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false

        searchController
            .searchTextPublisher
            .debounce(for: .milliseconds(900), scheduler: DispatchQueue.main)
            .assign(to: \.searchInput, on: viewModel)
            .store(in: &cancellables)

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension RepositoryListViewController: RepositoryListViewDelegate {
    func repositoryListView(_ repositoryListView: RepositoryListView, didSelect item: Item) {
        delegate?.repositoryListViewController(self, didSelect: item)
    }
}
