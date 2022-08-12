//
//  ProductListInteractor.swift
//  Saal
//
//  Created by Mozhgan 
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import Combine

final class ProductListInteractor : ProductListInteractorInterface {
    var storageContext : StorageContext
    
    init(storageContext : StorageContext) {
        self.storageContext = storageContext
    }
    
    func delete(id: String) {
        guard let product = storageContext.fetch(Product.self,
                                                 predicate: .init(format: "\(Product.primaryKey()!) = %@", id),
                                                 sorted: nil).first else {
            return
        }
        storageContext.delete(object: product)
    }
    
    func search(keyword: String) -> AnyPublisher<[Product], Never> {
        let list = storageContext.fetch(Product.self,
                                              predicate: .init(format: "\(Product.Key.name.rawValue) CONTAINS[c] %@ or \(Product.Key.productDescription.rawValue) CONTAINS[c] %@ or (ANY \(Product.Key.category).name CONTAINS[c] %@)", keyword,keyword,keyword),
                                              sorted: .init(key: Product.Key.name.rawValue))
        return Just(Array(list)).eraseToAnyPublisher()
    }
    
    func fetch() -> AnyPublisher<[Product], Never> {
        let list = storageContext.fetch(Product.self,
                                              predicate: nil,
                                              sorted: .init(key: Product.Key.name.rawValue))
        return Just(Array(list)).eraseToAnyPublisher()
    }
    
    func findBy(id: String) -> AnyPublisher<Product, Never> {
        guard let product = storageContext.fetch(Product.self,
                                                 predicate: .init(format: "\(Product.Key.id) == %@", id),
                                                 sorted: nil).first else {
            return Empty().eraseToAnyPublisher()
        }
        return Just(product).eraseToAnyPublisher()
    }
}