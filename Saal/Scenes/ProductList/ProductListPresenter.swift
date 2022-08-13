//
//  ProductListPresenter.swift
//  Saal
//
//  Created by Mozhgan
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import Combine

extension ProductListViewController {
    enum ViewEvent {
        case viewDidLoad
        case search(keyword : String?)
        case delete(product : ProductViewItem)
        case update(product : ProductViewItem)
        case add
    }
}

final class ProductListPresenter : ProductListPresenterInterface {
    
    typealias ViewEvent = ProductListViewController.ViewEvent
    var viewEventSubject: PassthroughSubject<ViewEvent, Never> = .init()
    
    // MARK: - Private properties -
    private let interactor: ProductListInteractorInterface
    private let wireframe: ProductListWireframeInterface
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var products : [ProductViewItem] = []
    @Published private(set) var deletedProduct : ProductViewItem?
    @Published private var keyword : String? {
        didSet {
            $keyword
                .compactMap({$0})
                .dropFirst(2)
                .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
                .sink(receiveValue: {$0.isEmpty ? self.fetch() : self.search(keyword: $0)})
                .store(in: &cancellables)
        }
    }
  
    // MARK: - Lifecycle -
    
    init(
        interactor: ProductListInteractorInterface,
        wireframe: ProductListWireframeInterface
    ) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.listeningToEvents()
    }
    
    private func listeningToEvents() {
        viewEventSubject.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .viewDidLoad:
                self.fetch()
            case .search(keyword: let keyword):
                self.keyword = keyword
            case .delete(let product):
                self.delete(product: product)
            case .update(product: let product):
                self.update(product: product)
            case .add:
                self.wireframe.routeTo(desination: .add(delegate: self))
            }
        }.store(in: &cancellables)
    }
    
}
fileprivate extension ProductListPresenter {
    private func fetch() {
        interactor
            .fetch()
            .sink { [weak self] products in
            self?.products = products.map {
                ProductViewItem(id: $0.id,
                                categoryName: $0.category.first?.name ?? "",
                                name: $0.name,
                                comment: $0.productDescription ?? "")
            }
        }.store(in: &cancellables)
    }
    
    private func search(keyword : String) {
        interactor
            .search(keyword: keyword)
            .sink { [weak self] products in
                self?.products = products.map {
                    ProductViewItem(id: $0.id,
                                    categoryName: $0.category.first?.name ?? "",
                                    name: $0.name,
                                    comment: $0.productDescription ?? "")
                }
            }.store(in: &cancellables)
    }
    
    private func delete(product : ProductViewItem) {
        self.interactor.delete(id: product.id)
        self.deletedProduct = product
    }
    
    private func update(product : ProductViewItem) {
        self.interactor
            .findBy(id: product.id)
            .sink {[weak self] product in
                guard let self = self else { return}
                self.wireframe.routeTo(desination: .update(product: product, delegate: self))
            }.store(in: &cancellables)
    }
}
extension ProductListPresenter : ProductMoudleDelegate {
    func productDidUpdated(product: Product) {
        self.fetch()
    }
}
