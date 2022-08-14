//
//  ProductListPresenterTests.swift
//  SaalTests
//
//  Created by Mozhgan on 8/13/22.
//

@testable import Saal
import XCTest
import Combine

class ProductListPresenterTests: XCTestCase {
    private var presenter: ProductListPresenter<ImmediateScheduler>!
    private var router: MockProductListWireframe!
    private var interactor: ProductListInteractor!
    private var cancellables: Set<AnyCancellable> = []
    
    private var navigationOutputs: [ProductListViewController.Desination] = []
    
    override func setUp() {
        router = .init()
        interactor = try? .init(storageContext: RealmStorageContext(configuration: .inMemory(identifier: Contstant.memoryIdentifier)))
        interactor.storageContext.save(objects: [Product.employeeMax,Product.serverK32145,Product.desk34,Product.calculatorT5812])
        presenter = .init(interactor: interactor, wireframe: router, debounce: Debounce.test)
        router.navigationPublisher.sink { [weak self] desination in
            self?.navigationOutputs.append(desination)
        }.store(in: &cancellables)
    }
    
    override func tearDown() {
        cancellables = []
        navigationOutputs = []
    }
    
    func testViewDidLoad() {
        var productsOutputs: [ProductViewItem] = []
        self.presenter.viewEventSubject.send(.viewDidLoad)
        presenter.$products.sink { products in
            productsOutputs.append(contentsOf: products)
        }.store(in: &cancellables)
    }
    
    func testSerach() {
        var productsOutputs: [ProductViewItem] = []
        self.presenter.viewEventSubject.send(.search(keyword: "m"))
        self.presenter.viewEventSubject.send(.search(keyword: "ma"))
        self.presenter.viewEventSubject.send(.search(keyword: "max"))
        presenter.$products.sink { products in
            productsOutputs.append(contentsOf: products)
        }.store(in: &cancellables)
    }
    
    func testAdd() throws {
        self.presenter.viewEventSubject.send(.add)
        XCTAssertEqual(self.navigationOutputs.last,ProductListViewController.Desination.add(delegate:self.presenter))
    }
    
    func testUpdate() {
        let product = Product.desk34
        let productViewItem = ProductViewItem(id: product.id,
                                              categoryName: product.category.first?.name ?? "",
                                              name: product.name,
                                              comment: product.productDescription ?? "")
        self.presenter.viewEventSubject.send(.update(product: productViewItem))
        XCTAssertEqual(self.navigationOutputs.last,ProductListViewController.Desination.update(product: product, delegate: self.presenter))
    }
    
    func testDelete() {
        let product = Product.desk34
        let productViewItem = ProductViewItem(id: product.id,
                                              categoryName: product.category.first?.name ?? "",
                                              name: product.name,
                                              comment: product.productDescription ?? "")
        self.presenter.viewEventSubject.send(.delete(product: productViewItem))
        self.presenter.$deletedProduct.sink { deletedProduct in
            XCTAssertTrue(deletedProduct?.id == product.id)
        }.store(in: &cancellables)
    }

}
