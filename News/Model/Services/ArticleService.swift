//
//  RepoService.swift
//  test
//
//  Created by Antony Starkov on 25.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation
import Combine

protocol ArticleServiceType {
    func fetch(by category: Category, completion: @escaping (Result<[Article], Error>) -> Void)
    func fetch(by searchText: String, completion: @escaping (Result<[Article], Error>) -> Void)
}

final class ArticleService: ArticleServiceType {
    private let networking: NetworkingType = NewsApi()
    private let storage: PersistenceType = Persistence()
    private var token: AnyCancellable? = nil
    
    func fetch(by category: Category, completion: @escaping (Result<[Article], Error>) -> Void) {
        token?.cancel()
        
        let storedArticles = storage.fetch(by: category)
        if storedArticles.count > 0 {
            completion(.success(storedArticles))
        }
        
        let categoryId: String? = category != .top ? category.rawValue : nil
        token = networking.fetch(by: categoryId)
        .print()
        .sink(receiveCompletion: { completion in
            //print("Completion = \(completion)")
        }, receiveValue: { [weak self] response in
            if storedArticles != response.articles {
                self?.storage.save(articles: response.articles, category: category)
                completion(.success(response.articles))
            }
        })
    }
    
    func fetch(by searchText: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        token?.cancel()
        
        let storedArticles = storage.fetch(by: searchText)
        if storedArticles.count > 0 {
            completion(.success(storedArticles))
        }
        
        token = networking.search(by: searchText)
        .print()
        .sink(receiveCompletion: { completion in
            //print("Completion = \(completion)")
        }, receiveValue: { [weak self] response in
            if storedArticles != response.articles  {
                self?.storage.save(articles: response.articles, category: nil)
                completion(.success(response.articles))
            }
        })
    }
}

struct ArticleResponse: Codable  {
    let articles: [Article]
}
