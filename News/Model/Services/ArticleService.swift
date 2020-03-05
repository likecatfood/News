//
//  RepoService.swift
//  test
//
//  Created by Antony Starkov on 25.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation
import Combine

struct ArticleResponse: Codable  {
    let articles: [Article]
}

class ArticleService {
    private var token: AnyCancellable? = nil
    
    func fetch(by category: Category, completion: @escaping (Result<[Article], Error>) -> Void) {
        token?.cancel()
        
        let categoryId: String? = category != .top ? category.rawValue : nil
        token = NewsApi.fetchArticles(category: categoryId)
        .print()
        .sink(receiveCompletion: { completion in
            print("Completion = \(completion)")
        },
              receiveValue: { response in
                completion(.success(response.articles))
        })
    }
    
    func fetch(by searchText: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        token?.cancel()
        token = NewsApi.fetchArticles(by: searchText)
        .print()
        .sink(receiveCompletion: { completion in
            print("Completion = \(completion)")
        },
              receiveValue: { response in
                completion(.success(response.articles))
        })
    }
}
