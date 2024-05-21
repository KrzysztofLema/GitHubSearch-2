//
//  JsonParser.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation

protocol DataParserProtocol {
  func parse<T: Decodable>(data: Data) -> AnyPublisher<T, NetworkError>
}

final class DataParser: DataParserProtocol {
    
  private var jsonDecoder: JSONDecoder

  init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  }

  func parse<T: Decodable>(data: Data) -> AnyPublisher<T, NetworkError> {
      do {
         return Just(try jsonDecoder.decode(T.self, from: data))
              .setFailureType(to: NetworkError.self)
              .eraseToAnyPublisher()
      } catch {
          return Fail(error: NetworkError.dataParsingFailed)
              .eraseToAnyPublisher()
      }
  }
}
