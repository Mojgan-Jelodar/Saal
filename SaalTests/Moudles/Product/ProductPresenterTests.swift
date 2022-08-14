//
//  ProductTests.swift
//  SaalTests
//
//  Created by Mozhgan on 8/14/22.
//
@testable import Saal
import XCTest
import Combine

class ProductPresenterTests: XCTestCase {
    private var presenter: ProductPresenter!
    private var router: MockProductWireframe!
    private var interactor: ProductInteractor!
    
    let products : [Product] = [.employeeMax,.serverK32145,.desk34,.calculatorT5812]
    let categories = [Category.employee,Category.server,Category.desk,Category.calculator]
    let mockProductListMoudle = MockProductMoudleDelegate()
    private var productViewData : ProductViewData!
    private var cancellables: Set<AnyCancellable> = []
    private var navigationOutputs: [ProductViewController.Desination] = []
    
    override func setUp() {
        let realmStorageContext = try! RealmStorageContext(configuration: .inMemory(identifier: Contstant.memoryIdentifier))
        realmStorageContext.save(objects: categories)
        realmStorageContext.save(objects: products)
        
        router = .init()
        interactor = .init(storageContext: realmStorageContext,
                           product: products.first)
        interactor.storageContext.save(objects: products)
        presenter = .init(interactor: interactor, wireframe: router, moudleDelegate: mockProductListMoudle)
        
        router.navigationPublisher.sink { [weak self] desination in
            self?.navigationOutputs.append(desination)
        }.store(in: &cancellables)
        
        presenter.$productViewData
            .compactMap({$0})
            .sink { productViewData in
                self.productViewData = productViewData
            }.store(in: &cancellables)
        
    }
    
    override func tearDown() {
        cancellables = []
        navigationOutputs = []
    }
    
    func testSave() {
        presenter.viewEventSubject.send(.save)
        XCTAssertTrue(mockProductListMoudle.objectDidUpdated)
    }
    
    func testSelectedCategory() {
        let index = products.lastIndex(of: products.last!)!
        presenter.viewEventSubject.send(.selectedCategory(index: index))
        XCTAssertEqual(index, presenter.selectedIndex)
    }
    
    func testAddRelatedProduct() {
        presenter.viewEventSubject.send(.addRelatedProduct)
        guard let desination = self.navigationOutputs.last,
              case ProductViewController.Desination.addRelatedProduct(_,_) = desination  else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertTrue(true)
    }
    
    func testRemoveRelation() {
        let products = Array(self.products[1...])
        interactor.addRelations(products: products)
        let consideredProduct = products.first!
        let consideredProductViewModel =  ProductViewItem(id: consideredProduct.id,
                                                          categoryName: consideredProduct.category.first?.name ?? "",
                                                          name: consideredProduct.name,
                                                          comment: consideredProduct.productDescription ?? "")
        
        presenter.viewEventSubject.send(.removeRelation(product: consideredProductViewModel))
        XCTAssertTrue(mockProductListMoudle.objectDidUpdated)
        XCTAssertNotEqual(productViewData.relations.count,products.count)
        
    }
    
}

extension ProductPresenterTests {
    class MockProductMoudleDelegate : ProductMoudleDelegate {
        private(set) var objectDidUpdated:Bool!
        
        func productDidUpdated(product: Product) {
            objectDidUpdated = true
        }
    }
}
