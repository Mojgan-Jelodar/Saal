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
    @Persisted private var relations: List<Product>
    @Persisted(originProperty: Category.Key.products.rawValue) var category: LinkingObjects<Category>
    
    var relatedProducts : [Product] {
        return Array(relations)
    }
    
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
    
    func add(relation : Product) {
        if let realm = self.realm {
            realm.safeWrite {
                self.relations.append(relation)
            }
        } else {
            self.relations.append(relation)
        }
    }
    
    func add(relations : [Product]) {
        if let realm = self.realm {
            realm.safeWrite {
                self.relations.append(objectsIn: relations)
            }
        } else {
            self.relations.append(objectsIn: relations)
        }
    }
    
    func remove(relation : Product) {
        guard let index = relations.firstIndex(where: {$0.id == relation.id })  else { return }
        if let realm = self.realm {
            realm.safeWrite {
                self.relations.remove(at: index)
            }
        } else {
            self.relations.remove(at: index)
        }
    }
    
    func findBy(id : String) -> Product? {
        self.relations.first(where: {$0.id == id})
    }
}
extension Product {
    enum Key : String {
        case id,name,productDescription,relations,category
    }
}
