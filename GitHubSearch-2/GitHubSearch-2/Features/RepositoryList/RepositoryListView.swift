//
//  MainListViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 26/05/2024.
//

import UIKit
import TinyConstraints
import Combine

enum CellIdentifier: String {
  case cell
}

protocol RepositoryListViewDelegate: AnyObject {
    func repositoryListView(_ repositoryListView: RepositoryListView, didSelect item: Item)
}

final class RepositoryListView: BasicView {
    
    public weak var delegate: RepositoryListViewDelegate?
    
    let viewModel: RepositoryListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    @Published public private(set) var searchResults: [Item] = []
    
    let tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .plain)
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.cell.rawValue)
      tableView.insetsContentViewsToSafeArea = true
      tableView.contentInsetAdjustmentBehavior = .automatic
      return tableView
    }()
    
    init(frame: CGRect = .zero, viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        bindViewModel()
    }
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.edgesToSuperview()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
    }
    
    func bindViewModel() {
        viewModel
          .$searchResults
          .receive(on: DispatchQueue.main)
          .assign(to: \.searchResults, on: self)
          .store(in: &cancellables)

        viewModel
          .$searchResults
          .receive(on: DispatchQueue.main)
          .sink { [weak self] _ in
            self?.tableView.reloadData()
          }.store(in: &cancellables)
    }
}

extension RepositoryListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell.rawValue)
      cell?.textLabel?.text = searchResults[indexPath.row].name
      return cell!
    }
}

extension RepositoryListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchResults[indexPath.row]
        
        delegate?.repositoryListView(self, didSelect: item)
    }
}
