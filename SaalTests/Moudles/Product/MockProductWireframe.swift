//
//  MockProductWireframe.swift
//  SaalTests
//
//  Created by Mozhgan on 8/14/22.
//
@testable import Saal
import Foundation
import Combine

final class MockProductWireframe : ProductWireframeInterface {
    
    private let navigationSubject = PassthroughSubject<ProductViewController.Desination, Never>()
    
    var  navigationPublisher : AnyPublisher<ProductViewController.Desination, Never> {
        navigationSubject.eraseToAnyPublisher()
    }
    
    func routeTo(desination: ProductViewController.Desination) {
        switch desination {
        case .addRelatedProduct(suggestibleProducts: let suggestibleProducts, delegate: let delegate):
            navigationSubject.send(.addRelatedProduct(suggestibleProducts: suggestibleProducts, delegate: delegate))
        }
    }
}
