////
////  Realm+Async.swift
////  Saal
////
////  Created by Mozhgan
////
//
//import Foundation
import RealmSwift
//
extension Realm {
    func safeWrite(_ block: () -> Void) {
        if self.isInWriteTransaction {
            block()
            do {
                try self.commitWrite()
            } catch {
                print(error)
            }
        } else {
            do {
                try self.write(block)
            } catch {
                print(error)
            }
        }
    }
}
