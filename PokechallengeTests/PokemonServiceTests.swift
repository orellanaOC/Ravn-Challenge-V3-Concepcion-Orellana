//
//  PokemonServiceTests.swift
//  PokechallengeTests
//
//  Created by Concepcion Orellana on 6/27/22.
//

import XCTest

@testable import Pokechallenge

class PokemonServiceTests: XCTestCase {
    var configuration: URLSessionConfiguration!
    var sessionMock: URLSession!

    override func setUp() {
        configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        sessionMock = URLSession(configuration: configuration)
    }

    override func tearDown() async throws {
        configuration = nil
        sessionMock = nil
    }

    func testURLValidWithQueryItems() throws {
        // Given
        var calledRequest: URLRequest?
        let network = NetworkProvider(session: sessionMock)
        let service = PokemonService(provider: network, decoder: JSONDecoder())
        let expectation = XCTestExpectation(description: " ")
        let pokemonID: Int = 25

        // When
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(
                request.url,
                "The URL should be unwrapped but it could not be unwrapped"
            )
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: url,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                ),
                "The HTTPURLResponse should be unwrapped but it could not be unwrapped"
            )
            calledRequest = request
            return (response, "".data(using: .utf8))
        }
        let cancellable = service.getDetail(for: pokemonID)
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { _ in }
            )
        wait(for: [expectation], timeout: 5)

        let components = URLComponents(url: try XCTUnwrap(calledRequest?.url), resolvingAgainstBaseURL: true)

        // Then

        XCTAssertNotNil(calledRequest?.url)
        XCTAssertEqual(components?.path, "/api/v2/pokemon-species/\(pokemonID)")
        XCTAssertNotNil(
            cancellable,
            "cancellable should not be nil"
        )
    }
}
