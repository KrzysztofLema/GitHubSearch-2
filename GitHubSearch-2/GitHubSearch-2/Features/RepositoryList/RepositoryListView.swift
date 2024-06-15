//
//  RepositoryListView.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 26/05/2024.
//

import Combine
import TinyConstraints
import UIKit
import GHSModels

enum CellIdentifier: String {
    case cell
}

protocol RepositoryListViewDelegate: AnyObject {
    func repositoryListView(_ repositoryListView: RepositoryListView, didSelect item: Item)
}

final class RepositoryListView: BasicView {
    private enum Section {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Item>

    public weak var delegate: RepositoryListViewDelegate?

    let viewModel: RepositoryListViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource: DataSource = createDataSource()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createGitHubRepositoriesListLayout())

    @Published public private(set) var searchResults: [Item] = []

    init(frame: CGRect = .zero, viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init()

        collectionView.delegate = self

        bindViewModel()
    }

    override func addSubviews() {
        super.addSubviews()
        addSubview(collectionView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        collectionView.edgesToSuperview()
    }

    override func setupSubviews() {
        super.setupSubviews()

        collectionView.register(RepositoryListCell.self, forCellWithReuseIdentifier: RepositoryListCell.reuseIdentifier)

        loadItems()
    }

    private func bindViewModel() {
        viewModel
            .$searchResults
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellables)

        viewModel
            .$searchResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadItems()
            }
            .store(in: &cancellables)
    }

    private func createGitHubRepositoriesListLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150.0))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }

    private func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, _ -> UICollectionViewCell? in

            let cell: RepositoryListCell = collectionView.dequeueCell(for: indexPath)
            let itemViewModel = ItemViewModel(item: self.viewModel.searchResults[indexPath.row])

            cell.configure(with: itemViewModel)

            return cell
        }
        return dataSource
    }

    private func loadItems() {
        var snapshot = DataSourceSnapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.searchResults)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension RepositoryListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            delegate?.repositoryListView(self, didSelect: item)
        }
    }
}
