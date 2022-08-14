//
//  RealmStorageTests.swift
//  SaalTests
//
//  Created by Mozhgan 
//
@testable import Saal
import XCTest
import Realm
import RealmSwift

class RealmStorageTests: XCTestCase {
    
    private var subjectUnderTest : RealmStorageContext?
    
    override  func setUp() {
        do {
            subjectUnderTest = try .init(configuration: .inMemory(identifier: UUID().uuidString))
        } catch let error {
            XCTAssertThrowsError(error.localizedDescription)
        }
    }
    
    func testSaveObject() {
        //Given
        let category = Category.desk
        //When
        subjectUnderTest?.save(object: category)
        let shoes = subjectUnderTest?.fetch(Category.self,
                                            predicate: NSPredicate(format: "\(Category.primaryKey()!) == %@", category.id),
                                            sorted: nil)
        //Then
        XCTAssertEqual(shoes?.count, 1)
        XCTAssertEqual(category, shoes?.first)
    
    }
    
    func testSaveObjects() {
        //Given
        let desk = Category.desk
        let server = Category.server
        let employee = Category.employee
        let calculator = Category.calculator
        
        let desk34 = Product.desk34
        let calculatorT5812 = Product.calculatorT5812
        let employeeMax = Product.employeeMax
        let serverK32145 = Product.serverK32145
        
        desk.products.append(desk34)
        calculator.products.append(calculatorT5812)
        employee.products.append(employeeMax)
        server.products.append(serverK32145)
        
        desk34.add(relation: calculatorT5812)
        desk34.add(relation :employeeMax)

        serverK32145.add(relation :employeeMax)
        
        let categories = [desk,server,employee,calculator]
        
        //When
        subjectUnderTest?.save(objects: categories)
        let list = subjectUnderTest?.fetch(Category.self,
                                           predicate: .init(format: "\(Category.primaryKey()!) == %@ or \(Category.primaryKey()!) == %@", categories.first!.id,categories.last!.id),
                                           sorted: nil)
        //Then
        XCTAssertEqual(list?.count, 2)
    }
    
    func testDeleteObject() {
        //Given
        let category = Category.desk
        guard let shoes = subjectUnderTest?.fetch(Category.self,
                                                  predicate: .init(format: "\(Category.primaryKey()!) == %@", category.id),
                                                  sorted: nil).first else { return }
        //When
        subjectUnderTest?.delete(object: shoes)
        //Then
        guard let list = subjectUnderTest?.fetch(Category.self,
                                                 predicate: .init(format: "\(Category.primaryKey()!) == %@", category.id),
                                                 sorted: nil) else { return }
        XCTAssertEqual(list.count, 0)
    }

}
