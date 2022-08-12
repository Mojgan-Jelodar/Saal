//
//  ProductViewAction.swift
//  Saal
//
//  Created by Mozhgan
//

import Foundation
import Combine
import UIKit
protocol ProductActions {
    var actions : [UIAction]? { get }
}
protocol ProductViewCellActions : ProductActions {
    associatedtype ViewEvent
    var actionPublisher: AnyPublisher<ViewEvent, Never> { get }
    var product : ProductViewItem { get }
    init(product : ProductViewItem)
}
