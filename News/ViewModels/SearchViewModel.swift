//
//  SearchViewModel.swift
//  test
//
//  Created by Antony Starkov on 03.03.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation

final class SearchViewModel: ObservableObject {
    private let service: ArticleService = ArticleService()
    
    @Published var showCancelButton: Bool = false
    @Published var articles = [ArticleViewModel]()
    @Published var searchText: String = ""
    
    func load() {
        articles.removeAll()
        if !searchText.isEmpty {
            fetchArticles()
        }
    }
    
    private func fetchArticles() {
        service.fetch(by: searchText) { result in
            switch result {
            case .success(let articleModels):
                self.articles = articleModels.map { ArticleViewModel(article: $0) }

            case .failure(_):
                ()
            }
        }
    }
}
