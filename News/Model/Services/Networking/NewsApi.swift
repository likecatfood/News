//
//  NewsApi.swift
//  test
//
//  Created by Antony Starkov on 28.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation
import Combine

struct Agent {
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

struct NewsApi {
    fileprivate static let agent = Agent()
    private static let apiKey = "Insert Your Api Key Here"
    
    fileprivate static func buildUrl(endpoint: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "newsapi.org"
        components.path = "/v2/" + endpoint
        components.queryItems = [URLQueryItem(name: "apiKey", value: apiKey)] + queryItems
        return components.url
    }
}

extension NewsApi {
    static func fetchArticles(by country: String = "us", category: String?) -> AnyPublisher<ArticleResponse, Error> {
        var queries = [URLQueryItem(name: "country", value: country)]
        if let category = category {
            queries.append(URLQueryItem(name: "category", value: category))
        }
        let url = buildUrl(endpoint: "top-headlines", queryItems: queries)!
        return runRequest(url: url)
    }
    
    static func fetchArticles(by searchText: String) -> AnyPublisher<ArticleResponse, Error> {
        let queries = [URLQueryItem(name: "q", value: searchText)]
        let url = buildUrl(endpoint: "everything", queryItems: queries)!
        return runRequest(url: url)
    }
    
    private static func runRequest(url: URL) -> AnyPublisher<ArticleResponse, Error> {
        let request = URLRequest(url: url)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}


