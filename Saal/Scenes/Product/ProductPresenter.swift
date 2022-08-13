//
//  AddOrUpdateProductPresenter.swift
//  Saal
//
//  Created by Mozhgan
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import Combine

extension ProductViewController {
    enum ViewEvent {
        case save
        case selectedCategory(index : Int)
        case addRelatedProduct
        case removeRelation(product : ProductViewItem)
    }
}

fileprivate protocol ProductMoudleProtocol : AnyObject {
    func productRelatedDidUpdated(products:[Product])
}

final class ProductPresenter : ProductPresenterInterface {
    
    typealias ViewEvent = ProductViewController.ViewEvent
    var viewEventSubject: PassthroughSubject<ViewEvent, Never>

    // MARK: - Private properties -
    private let interactor: ProductInteractorInterface
    private let wireframe: ProductWireframeInterface
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var productViewData: ProductViewData?
    private(set) var selectedIndex : Int?
    weak var moudleDelegate : ProductMoudleDelegate?
    
    // MARK: - Lifecycle -

    init(
        interactor: ProductInteractorInterface,
        wireframe: ProductWireframeInterface,
        moudleDelegate : ProductMoudleDelegate
    ) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.moudleDelegate = moudleDelegate
        self.viewEventSubject = .init()
        self.listeningToEvents()
        self.binding()
    }

    
    private func listeningToEvents() {
        viewEventSubject.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .save:
                self.save()
            case .selectedCategory(let index):
                self.selectedIndex = index
            case .addRelatedProduct:
                self.getRelatedProducts()
            case .removeRelation(product: let product):
                self.removeRelation(product: product)
            }
        }.store(in: &cancellables)
    }
  
    private func binding() {
        interactor.categories.combineLatest(interactor.product).map({ (categories,product) -> ProductViewData? in
            let productViewData = ProductViewData(product: product, categories: categories)
            return productViewData
        }).assign(to: &self.$productViewData)
    }
    
    
    private func removeRelation(product: ProductViewItem) {
        interactor.deleteRelation(id: product.id)
    }
    
    private func save() {
        guard let id = self.productViewData?.id,
              let name = productViewData?.title,
              let selectedIndex = self.selectedIndex,
              let categoryId = self.productViewData?.categories[selectedIndex].id else {
            return
        }
        interactor.addProduct(id: id,
                              name: name,
                              description: productViewData?.description ?? nil,
                              categoryId: categoryId,
                              relations: productViewData?.relations.map({$0.id} ))
    }
    
    private func getRelatedProducts() {
        interactor.getSuggestibleProducts().sink { [weak self] products in
            guard let self = self else { return }
            self.wireframe.routeTo(desination: .addRelatedProduct(suggestibleProducts: products, delegate: self))
        }.store(in: &cancellables)
    }
}

extension ProductPresenter : SuggestibleProductsWireframeMoudleDelegate {
    func didFinish(relatedProducts: [Product]) {
        self.productRelatedDidUpdated(products: relatedProducts)
    }
}
extension ProductPresenter : ProductMoudleProtocol {
    func productRelatedDidUpdated(products: [Product]) {
        self.interactor.addRelations(products: products)
    }
}
