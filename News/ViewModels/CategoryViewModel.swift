//
//  CategoryViewModel.swift
//  test
//
//  Created by Antony Starkov on 27.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation

final class CategoryViewModel: Identifiable {
    let entity: Category
    
    var id: String {
        return entity.rawValue
    }
    
    var title: String {
        return id.capitalized
    }
    
    init(with category: Category) {
        self.entity = category
    }
}

extension CategoryViewModel: Equatable {
    static func == (lhs: CategoryViewModel, rhs: CategoryViewModel) -> Bool {
        return lhs.entity == rhs.entity
    }
}
