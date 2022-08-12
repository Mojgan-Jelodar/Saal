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
}
extension Category {
    enum Key : String {
        case id,name,comment,products
    }
}
