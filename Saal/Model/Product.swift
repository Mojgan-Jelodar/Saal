//
//  File.swift
//  Saal
//
//  Created by Mozhgan 
//

import Foundation
import RealmSwift
final public class Product: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name : String
    @Persisted var productDescription : String?
    @Persisted var relations: List<Product>
    @Persisted(originProperty: Category.Key.products.rawValue) var category: LinkingObjects<Category> 
    
    public convenience  init(id: String,
                             name: String,
                             productDescription: String?) {
        self.init()
        self.id = id
        self.name = name
        self.productDescription = productDescription
    }
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
extension Product {
    enum Key : String {
        case id,name,productDescription,relations,category
    }
}
