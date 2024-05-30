//
//  JsonParser.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation

protocol DataParserType {
    func decode<T: Decodable>(data: Data) -> AnyPublisher<T, NetworkError>
}

final class DataParser: DataParserType {
    
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func decode<T: Decodable>(data: Data) -> AnyPublisher<T, NetworkError> {
        do {
            return Just(try jsonDecoder.decode(T.self, from: data))
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch let error {
            #if DEBUG
            print("Decode error = \(error)")
            #endif
            return Fail(error: NetworkError.dataParsingFailed)
                    .eraseToAnyPublisher()
        }
    }
}

struct DataParserKey: InjectionKey {
    static var currentValue: DataParserType = DataParser()
}

extension InjectedValues {
    var dataParser: DataParserType {
        get { Self[DataParserKey.self] }
        set { Self[DataParserKey.self] = newValue }
    }
}
