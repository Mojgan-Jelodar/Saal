//
//  StorageContext.swift
//  DataReader
//
//  Created by mozhgan
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation
import RealmSwift

struct Sorted {
    var key: String
    var ascending: Bool = true
}

/*
 Operations on context
 */
protocol StorageContext {
    /*
     Save an object that is conformed to the `Storable` protocol
     */
    func save<T: Object>(object: T)
    
    /*
     Save an object that is conformed to the `Storable` protocol
     */
    func save<T: Object>(objects: [T])
    /*
     Delete an object that is conformed to the `Storable` protocol
     */
    func delete<T: Object>( object : T)
    /*
     Return a list of objects that are conformed to the `Storable` protocol
     */
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> Results<T>
}
