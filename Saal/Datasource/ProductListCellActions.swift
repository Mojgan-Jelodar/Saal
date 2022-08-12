//
//  ProductListCellAction.swift
//  Saal
//
//  Created by Mozhgan
//

import UIKit
import Combine
final class ProductListCellActions :  ProductViewCellActions {
    typealias ViewEvent = Event
    private var viewEventSubject: PassthroughSubject<ViewEvent, Never> = .init()
    var product : ProductViewItem
    
    var actionPublisher: AnyPublisher<ViewEvent, Never> {
        viewEventSubject.eraseToAnyPublisher()
    }
    
    init(product : ProductViewItem) {
        self.product = product
    }
    
    var actions: [UIAction]? {
        [
            .init(title: R.string.product.editButton(),
                  image: UIImage(named: "pencil.line")) { action in
                      self.viewEventSubject.send(.update(product: self.product))
                  }
            ,
            .init(title: R.string.product.deleteButton(),
                  image: UIImage(systemName: "trash"),
                  attributes: UIMenuElement.Attributes.destructive) { action in
                      self.viewEventSubject.send(.delete(product: self.product))
                  }
        ]
    }
}


extension ProductListCellActions {
    enum Event {
        case update(product : ProductViewItem)
        case delete(product : ProductViewItem)
    }
}
