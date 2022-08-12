//
//  ProductViewData.swift
//  Saal
//
//  Created by Mozhgan
//

import Foundation
class ProductViewData {
    private(set) var id : String?
    private(set) var title : String?
    private(set) var description : String?
    private(set) var categories : [CategoryViewData]
    private(set) var relations : [ProductViewItem] = []
    
    init(product : Product?,
         categories : [Category]) {
        self.id = product?.id
        self.title = product?.name
        self.description = product?.productDescription
        self.categories = categories.map({.init(category: $0, isSelected: product?.category.first == $0)})
        guard let relations = product?.relations else { return  }
        self.relations = Array(relations).map({ProductViewItem(id: $0.id,
                                                               categoryName: $0.category.first?.name ?? "",
                                                               name: $0.name,
                                                               comment: $0.productDescription ?? "")})
    }
    
    func set(id : String?) -> ProductViewData {
        self.id = id ?? ""
        return self
    }
    
    func set(title : String?) -> ProductViewData {
        self.title = title
        return self
    }
    
    func set(description : String?) -> ProductViewData {
        self.description = description
        return self
    }
    
    func set(categories : [CategoryViewData]) -> ProductViewData {
        self.categories = categories
        return self
    }
    
    func set(relations : [Product]) -> ProductViewData {
        self.relations = relations.map({.init(id: $0.id,
                                              categoryName: $0.category.first?.name ?? "",
                                              name: $0.name,
                                              comment: $0.productDescription ?? "")})
        return self
    }
}

extension ProductViewData {
    struct CategoryViewData {
        let id : String
        let name : String
        let isSelected : Bool
        init(category : Category,isSelected : Bool) {
            self.id = category.id
            self.name = category.name
            self.isSelected = isSelected
        }
    }
}

