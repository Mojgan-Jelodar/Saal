//
//  Category.swift
//  Saal
//
//  Created by Mozhgan 
//

import Foundation
import RealmSwift

final public class Category: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var name : String
    @Persisted public var comment : String
    @Persisted var products: List<Product>
    
    public convenience init(id:String,
                            name: String,
                            comment: String) {
        self.init()
        self.id = id
        self.name = name
        self.comment = comment
    }
    
    public override class func primaryKey() -> String? {
        "id"
    }
    
    func add(product : Product) {
        if self.products.first(where: { $0.id == product.id}) == nil  {
            if let realm = self.realm {
                realm.safeWrite {
                    self.products.append(product)
                }
            } else {
                self.products.append(product)
            }
        }
    }
    func add(products : [Product]) {
        for product in products {
            self.add(product: product)
        }
    }
    
}
extension Category {
    enum Key : String {
        case id,name,comment,products
    }
}
