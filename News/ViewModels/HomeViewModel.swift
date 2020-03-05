//
//  HomeViewModel.swift
//  test
//
//  Created by Antony Starkov on 26.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    private let service: ArticleService = ArticleService()
    
    @Published var isLoading: Bool = true
    
    @Published var articles = [ArticleViewModel]()
    
    @Published var category: CategoryViewModel {
        didSet {
            load()
        }
    }

    var avaliableCategories: [CategoryViewModel] = Category.allCases.map { CategoryViewModel(with: $0) }
    
    init() {
        category = CategoryViewModel(with: .top)
        load()
    }
    
    private func load() {
        articles.removeAll()
        fetchArticles()
    }
    
    private func fetchArticles() {
        isLoading = true
        
        service.fetch(by: category.entity) { result in
            switch result {
            case .success(let articleModels):
                self.articles = articleModels.map { ArticleViewModel(article: $0) }
                self.isLoading = false

            case .failure(_):
                ()
            }
        }
    }
}

