//
//  NetworkProvider.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/23/22.
//

import Combine
import Foundation

protocol NetworkProviderType {
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder) -> AnyPublisher<Response<T>, Error>
}

struct NetworkProvider: NetworkProviderType {
    var session: URLSession = .shared

    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }

                guard !result.data.isEmpty else {
                    throw URLError(.zeroByteResource)
                }

                let value = try decoder.decode(T.self, from: result.data)

                return Response(value: value, response: result.response)
            }
            .eraseToAnyPublisher()
    }
}
