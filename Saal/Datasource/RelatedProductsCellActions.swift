//
//  RelatedProductsCellActions.swift
//  Saal
//
//  Created by Mozhgan on 8/10/22.
//

import Foundation
import UIKit
import Combine
final class RelatedProductsCellActions :  ProductViewCellActions {
    typealias ViewEvent = Event
    private var viewEventSubject: PassthroughSubject<ViewEvent, Never> = .init()
    var product : ProductViewItem
    
    var actionPublisher: AnyPublisher<Event, Never> {
        viewEventSubject.eraseToAnyPublisher()
    }
    
    init(product : ProductViewItem) {
        self.product = product
    }
    
    var actions: [UIAction]? {
        [
            .init(title: R.string.product.deleteButton(),
                  image: UIImage(systemName: "trash"),
                  attributes: UIMenuElement.Attributes.destructive) { action in
                      self.viewEventSubject.send(.delete(product: self.product))
                  }
        ]
    }
}


extension RelatedProductsCellActions {
    enum Event {
        case delete(product : ProductViewItem)
    }
}
