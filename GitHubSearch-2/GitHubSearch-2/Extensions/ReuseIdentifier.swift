//
//  ReuseIdentifier.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 30/05/2024.
//

import UIKit

public protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReuseIdentifier {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: ReuseIdentifier {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
