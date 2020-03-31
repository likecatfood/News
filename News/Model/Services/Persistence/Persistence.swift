//
//  Persistance.swift
//  News
//
//  Created by Antony Starkov on 31.03.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation
import RealmSwift

protocol PersistenceType {
    func save(articles: [Article], category: Category?)
    func fetch(by category: Category) -> [Article]
    func fetch(by searchText: String) -> [Article]
}

final class Persistence: PersistenceType {
    let realm = try! Realm()
        
    func save(articles: [Article], category: Category?) {
        let realmArticles = articles.map { RealmArticle(article: $0, category: category) }
        try? realm.write {
            realm.add(realmArticles)
        }
    }
    
    func fetch(by category: Category) -> [Article] {
        realm.objects(RealmArticle.self).filter("categoryId == %@", category.rawValue).prefix(20).map { $0.raw }
    }
    
    func fetch(by searchText: String) -> [Article] {
        realm.objects(RealmArticle.self).filter("title contains[c] %@", searchText).map { $0.raw }
    }
}

final class RealmArticle: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var descr: String? = nil
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String? =  nil
    @objc dynamic var content: String? = nil
    @objc dynamic var categoryId: String? = nil
}

extension RealmArticle {
    convenience init(article: Article, category: Category?) {
        self.init()
        self.title = article.title
        self.descr = article.description
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.content = article.content
        self.categoryId = category?.rawValue
    }
    
    var raw: Article {
        return Article(title: title, description: descr, url: url, urlToImage: urlToImage, content: content)
    }
}

