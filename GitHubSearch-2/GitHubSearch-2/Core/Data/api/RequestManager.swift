//
//  RequestManager.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation

protocol RequestManagerType {
    func perform<T: Decodable>(_ request: RequestProtocol, type: T.Type) throws -> AnyPublisher<T, NetworkError>
}

final class RequestManager: RequestManagerType {
    
    @Injected(\.dataParser) var dataParser: DataParserType
    
    private let urlSession: URLSession
    
    init(
        sessionConfiguration: URLSessionConfiguration = .default
    ) {
        self.urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    func perform<T: Decodable>(_ request: RequestProtocol, type: T.Type) throws -> AnyPublisher<T, NetworkError> {
        let apiQueue = DispatchQueue(label: APIConstants.apiQueueLabel, qos: .userInitiated, attributes: .concurrent)
        
        return perform(try request.createURLRequest())
            .subscribe(on: apiQueue)
            .flatMap { data in
                self.dataParser.parse(data: data)
            }
            .eraseToAnyPublisher()
    }
    
    private func perform(_ request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.responseMissing
                }
                return data
            }.mapError { [weak self] error in
                guard let self else {
                    return .networkError
                }
                return self.mapRequestError(error)
            }.flatMap { [weak self] data in
                guard let self else {
                    return Fail<Data, NetworkError>(error: NetworkError.invalidURL)
                        .eraseToAnyPublisher()
                }
                return Just(data)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func mapRequestError(_ error: Error) -> NetworkError {
        let nsError = error as NSError
        guard nsError.code == NSURLErrorNotConnectedToInternet else {
            return .requestError
        }
        
        return .notConnectedToInternet
    }
}

struct RequestManagerKey: InjectionKey {
    static var currentValue: RequestManagerType = RequestManager()
}

extension InjectedValues {
    var requestManager: RequestManagerType {
        get { Self[RequestManagerKey.self] }
        set { Self[RequestManagerKey.self] = newValue }
    }
}

