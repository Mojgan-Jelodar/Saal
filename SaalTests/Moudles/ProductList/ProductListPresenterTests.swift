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
        interactor.storageContext.save(objects: [Product.employeeMax,Product.serverK32145])
        presenter = .init(interactor: interactor, wireframe: router, debounce: .test)
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
        self.presenter.viewEventSubject.send(.search(keyword: "ma"))
        presenter.$products.sink { products in
            productsOutputs.append(contentsOf: products)
        }.store(in: &cancellables)
    }

}

fileprivate extension ProductViewItem {
    static let products : [ProductViewItem] = [.init(id: Product.employeeMax.id,
                                                    categoryName: Product.employeeMax.category.first?.name ?? "",
                                                    name: Product.employeeMax.name,
                                                    comment: Product.employeeMax.productDescription ?? ""),
                                               .init(id: Product.desk34.id,
                                                     categoryName: Product.desk34.category.first?.name ?? "",
                                                                                               name: Product.desk34.name,
                                                                                               comment: Product.desk34.productDescription ?? "")]
}
