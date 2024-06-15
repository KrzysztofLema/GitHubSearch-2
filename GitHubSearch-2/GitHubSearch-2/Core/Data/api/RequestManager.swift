//
//  RequestManager.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation
import GHSDependecyInjection
import GHSModels

protocol RequestManagerType {
    func perform<T: Decodable>(_ request: RequestProtocol, type: T.Type) throws -> AnyPublisher<T, NetworkError>
}

final class RequestManager: RequestManagerType {
    @Injected(\.dataParser) var dataParser: DataParserType

    private let urlSession: URLSession

    init(
        sessionConfiguration: URLSessionConfiguration = .default
    ) {
        urlSession = URLSession(configuration: sessionConfiguration)
    }

    func perform<T: Decodable>(_ request: RequestProtocol, type: T.Type) throws -> AnyPublisher<T, NetworkError> {
        let apiQueue = DispatchQueue(label: APIConstants.apiQueueLabel, qos: .userInitiated, attributes: .concurrent)

        return perform(try request.createURLRequest())
            .subscribe(on: apiQueue)
            .flatMap(dataParser.decode(data:))
            .eraseToAnyPublisher()
    }

    private func perform(_ request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        urlSession.dataTaskPublisher(for: request)
            .map(\.data)
            .mapError(mapRequestError(_:))
            .flatMap(flatMapRequestData(_:))
            .eraseToAnyPublisher()
    }

    private func mapRequestError(_ error: Error) -> NetworkError {
        let nsError = error as NSError
        guard nsError.code == NSURLErrorNotConnectedToInternet else {
            return .requestError
        }

        return .notConnectedToInternet
    }

    private func flatMapRequestData(_ data: Data) -> AnyPublisher<Data, NetworkError> {
        Just(data)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
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
