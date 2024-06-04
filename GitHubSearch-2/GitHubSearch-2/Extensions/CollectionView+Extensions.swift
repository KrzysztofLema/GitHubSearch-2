//
//  CollectionView+Extensions.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 04/06/2024.
//

import UIKit

extension UICollectionView {
    public func dequeueCell<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Error: Cell with id: \(T.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}
