//
//  File.swift
//  Choco
//
//  Created by Mozhgan 
//

import Foundation
import RealmSwift
import Combine

// swiftlint:disable force_cast

final class RealmStorageContext: StorageContext {
    var realm: Realm?
    
    required init(configuration: ConfigurationType = .basic(url: nil)) throws {
        var rmConfig = Realm.Configuration()
        rmConfig.readOnly = true
        switch configuration {
        case .basic:
            rmConfig = Realm.Configuration.defaultConfiguration
            if let url = configuration.associated {
                rmConfig.fileURL = NSURL(string: url) as URL?
            }
        case .inMemory:
            rmConfig = Realm.Configuration()
            if let identifier = configuration.associated {
                rmConfig.inMemoryIdentifier = identifier
            } else {
                throw NSError()
            }
        }
        try self.realm = Realm(configuration: rmConfig)
    }
}


extension RealmStorageContext {
    func save<T>(object: T)  where T : Object {
        if let realm = object.realm ?? self.realm {
            realm.safeWrite({
                realm.add(object, update: .modified)
            })
        }
    }
    
    func save<T>(objects: [T])  where T : Object {
        for object in objects {
            self.save(object: object)
        }
    }
}

extension RealmStorageContext {
    
    func delete<T: Object>( object : T)  {
        if let realm = object.realm ?? self.realm {
            realm.safeWrite({
                realm.delete(object)
            })
        }
    }
}

extension RealmStorageContext {
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> Results<T> {
        var objects = self.realm!.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        return objects
    }
}
