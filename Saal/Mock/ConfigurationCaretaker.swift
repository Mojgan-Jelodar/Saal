//
//  File.swift
//  Saal
//
//  Created by Mozhgan on 8/11/22.
//

import Foundation
protocol Configuration: Equatable {}
extension Int : Configuration {}
extension Bool : Configuration {}
extension String : Configuration {}

final class Memento<T:Configuration> : Equatable {
    var configuration: T!
    init(configuration: T) {
        self.configuration = configuration
    }
    static func == (lhs: Memento<T>, rhs: Memento<T>) -> Bool {
        lhs.configuration == rhs.configuration
    }
}

final class ConfigurationCaretaker<T:Configuration>{
    private let key : String
    required init(key : String) {
        self.key = key
    }
    func saveMemento(configurationMemento: Memento<T>) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(configurationMemento.configuration, forKey: key)
        userDefaults.synchronize()
    }
    func restoreMemento() -> Memento<T>? {
        let userDefaults = UserDefaults.standard
        if let configuration = userDefaults.value(forKey: key) as? T {
            return Memento(configuration: configuration)
        }
        return nil
    }
}
