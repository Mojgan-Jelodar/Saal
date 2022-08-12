//
//  Realm+Storable.swift
//  Choco
//
//  Created by Mozhgan 
//

import RealmSwift

/* Storage config options */
public enum ConfigurationType {
    case basic(url: String?)
    case inMemory(identifier: String?)
    
    var associated: String? {
        get {
            switch self {
            case .basic(let url): return url
            case .inMemory(let identifier): return identifier
            }
        }
    }
}
