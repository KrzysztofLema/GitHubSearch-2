//
//  FooterReposiotoryTextBuilder.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 04/06/2024.
//

import UIKit

final public class FooterRepositoryTextBuilder {
    
    private struct Constants {
        static let separator = " • "
    }
    
    private var footer: [NSAttributedString] = []
    private let result = NSMutableAttributedString(string: "")
    
    public init() {}
    
    public func with(shouldShowSeparatorAtBeginning: Bool) -> Self {
        guard shouldShowSeparatorAtBeginning else {
            return self
        }
        
        let mainSeparator = NSAttributedString(string: Constants.separator)
        footer.append(mainSeparator)
        
        return self
    }
    
    public func withSeparator() -> Self {
        footer.append(NSAttributedString(string: Constants.separator))
        
        return self
    }
    
    public func with(text: String?) -> Self {
        if let text {
            footer.append(NSAttributedString(string: text))
        }
        
        return self
    }
    
    public func with(image: UIImage?, text: String?) -> Self {
        let textWithImage = NSMutableAttributedString()
        
        if let text {
            textWithImage.append(NSAttributedString(string: String(" \(text)")))
        }
        
        if let image {
            let imageAttachment = NSTextAttachment(image: image)
            
            textWithImage.insert(NSAttributedString(attachment: imageAttachment), at: 0)
        }
        
        footer.append(textWithImage)
        
        return self
    }
    
    public func build() -> NSAttributedString {
        footer.forEach {
            result.append($0)
        }
        
        return result
    }
}
