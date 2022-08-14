//
//  File.swift
//  SaalTests
//
//  Created by Mozhgan on 8/13/22.
//
@testable import Saal
import Foundation
import Combine

extension ProductListPresenterTests {
    final class MockProductListWireframe: ProductListWireframeInterface {
        
        private let navigationSubject = PassthroughSubject<ProductListViewController.Desination, Never>()
        
        var  navigationPublisher : AnyPublisher<ProductListViewController.Desination, Never> {
            navigationSubject.eraseToAnyPublisher()
        }
        
        func routeTo(desination: ProductListViewController.Desination) {
            switch desination {
            case .add(delegate: let delegate):
                navigationSubject.send(.add(delegate: delegate))
            case .update(product: let product, delegate: let delegate):
                navigationSubject.send(.update(product: product, delegate: delegate))
            }
        }
        
    }
}
