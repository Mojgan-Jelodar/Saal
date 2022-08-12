//
//  CategoryHelper.swift
//  Saal
//
//  Created by Mozhgan on 8/11/22.
//

import Foundation
struct CategoryHelper {
    let storageContext : StorageContext
    func register() {
        let configurationCaretaker = ConfigurationCaretaker<Bool>.init(key: "isFirtTime")
        let isFirtTime = configurationCaretaker.restoreMemento()?.configuration ?? true
        guard isFirtTime else {
            return
        }
        let categories : [Category] = [.employee,.desk,.calculator,.server]
        storageContext.save(objects: categories)
        configurationCaretaker.saveMemento(configurationMemento: .init(configuration: false))
    }
}
