//
//  NewsApi.swift
//  test
//
//  Created by Antony Starkov on 28.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation
import Combine

protocol NetworkingType {
    func fetch(by category: String?) -> AnyPublisher<ArticleResponse, Error>
    func search(by text: String) -> AnyPublisher<ArticleResponse, Error>
}

final class NewsApi: NetworkingType {
    private let agent = Agent()
    private static let apiKey = "de17c7aaab00408b9dbb33395ba98121"
    
    func fetch(by category: String?) -> AnyPublisher<ArticleResponse, Error> {
        var queries = [URLQueryItem(name: "country", value: "us")]
        if let category = category {
            queries.append(URLQueryItem(name: "category", value: category))
        }
        let url = buildUrl(endpoint: "top-headlines", queryItems: queries)!
        return runRequest(url: url)
    }
    
    func search(by text: String) -> AnyPublisher<ArticleResponse, Error> {
        let queries = [URLQueryItem(name: "q", value: text)]
        let url = buildUrl(endpoint: "everything", queryItems: queries)!
        return runRequest(url: url)
    }
    
    private func runRequest(url: URL) -> AnyPublisher<ArticleResponse, Error> {
        let request = URLRequest(url: url)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    private func buildUrl(endpoint: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "newsapi.org"
        components.path = "/v2/" + endpoint
        components.queryItems = [URLQueryItem(name: "apiKey", value: type(of: self).apiKey)] + queryItems
        return components.url
    }
}

private struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
