//
//  AddOrUpdateProductInteractor.swift
//  Saal
//
//  Created by Mozhgan
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import RealmSwift
import Combine

final class ProductInteractor {
    var product: AnyPublisher<Product?, Never> {
        productSubject.eraseToAnyPublisher()
    }
    var categories: AnyPublisher<[Category], Never> {
        return categorySubject.eraseToAnyPublisher()
    }
    
    private var productSubject : CurrentValueSubject<Product?,Never>
    private var categorySubject : CurrentValueSubject<[Category],Never>
    let storageContext : StorageContext
    init(storageContext : StorageContext,product : Product?) {
        self.storageContext = storageContext
        productSubject = .init(product)
        categorySubject = .init([])
        loadCategory()
    }
    
    private func loadCategory() {
        let categories =  self.storageContext.fetch(Category.self,
                                                    predicate: nil,
                                                    sorted: .init(key: "\(Category.Key.id.rawValue)"))
        categorySubject.send(Array(categories))
    }
    
    private func upadte(name: String,
                        description: String?,
                        categoryId: String) {
        let category = categorySubject.value.first(where: {$0.id == categoryId})!
        let product = productSubject.value!
                        .set(name: name)
                        .set(category: category)
                        .set(productDescription: description)
        storageContext.save(objects: [category,product])
        productSubject.send(product)
        
    }
    
    private func add(id: String,
                     name: String,
                     description: String?,
                     categoryId: String) {
        let category = categorySubject.value.first(where: {$0.id == categoryId})!
        let product = Product.init(id: id, name: name, productDescription: description)
        category.add(product: product)
        storageContext.save(objects: [category,product])
        productSubject.send(product)
        
    }
}

// MARK: - Extensions -

extension ProductInteractor: ProductInteractorInterface {
    func deleteRelation(id: String) {
        guard let product = self.productSubject.value,
              let relation = product.findBy(id: id) else {
            return
        }
        product.remove(relation: relation)
        productSubject.send(product)
    }
    
    func addProduct(id: String,
                    name: String,
                    description: String?,
                    categoryId: String) {
        
        if self.productSubject.value == nil {
            self.add(id: id, name: name, description: description, categoryId: categoryId)
        } else {
            self.upadte(name: name, description: description, categoryId: categoryId)
        }
        
    }
    
    func getSuggestibleProducts() -> AnyPublisher<[Product], Never> {
        var predicate :NSPredicate?
        if let product = self.productSubject.value {
            let ids : [String] = product.relatedProducts.map({$0.id})
            predicate = .init(format: "id != $id and not(id IN $ID_LIST)")
                .withSubstitutionVariables(["id" : product.id,
                                            "ID_LIST" : ids])
        }
        let suggestibleProducts = storageContext.fetch(Product.self, predicate: predicate, sorted: .init(key: "name"))
        return Just(Array(suggestibleProducts)).eraseToAnyPublisher()
    }
    
    func addRelations(products: [Product]) {
        guard let product = self.productSubject.value else { return  }
        product.add(relations: products)
        productSubject.send(product)
    }
}
