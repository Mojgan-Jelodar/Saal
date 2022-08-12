//
//  SuggestibleViewCellActions.swift
//  Saal
//
//  Created by Mozhgan on 8/12/22.
//

import Foundation
import UIKit
import Combine

struct SuggestibleViewCellActions : ProductViewCellActions {
    typealias ViewEvent = Void
    
    private var viewEventSubject: PassthroughSubject<ViewEvent, Never> = .init()
    
    var actionPublisher: AnyPublisher<ViewEvent, Never> {
        viewEventSubject.eraseToAnyPublisher()
    }
    
    var actions: [UIAction]? {
        return nil
    }
    
    var product: ProductViewItem
    
    init(product: ProductViewItem) {
        self.product = product
    }
   
}
