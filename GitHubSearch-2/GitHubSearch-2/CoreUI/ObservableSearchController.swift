//
//  ObservableSearchController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 26/05/2024.
//
import UIKit
import Combine

public class ObservableUISearchController: UISearchController, UISearchResultsUpdating {
    
    public var searchTextPublisher: AnyPublisher<String, Never> {
        searchTextSubject.eraseToAnyPublisher()
    }
    private let searchTextSubject = PassthroughSubject<String, Never>()
    
    public override var searchResultsUpdater: UISearchResultsUpdating? {
        willSet {
            guard newValue === self else {
                fatalError("Cannot set search results updater on ObservableSearchResultsController.")
            }
        }
    }
    
    public override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        self.searchResultsUpdater = self
        setupView()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        searchTextSubject.send(searchController.searchBar.text ?? "")
    }
    
    private func setupView() {
        searchBar.placeholder = "Znajdz repozytorium git"
    }
}
