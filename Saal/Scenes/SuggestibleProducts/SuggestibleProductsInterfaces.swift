//
//  SuggestibleProductsInterfaces.swift
//  Saal
//
//  Created by Mozhgan on 8/11/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

public protocol SuggestibleProductsWireframeMoudleDelegate : AnyObject {
    func didFinish(relatedProducts: [Product])
}

protocol SuggestibleProductsWireframeInterface: WireframeInterface {
    func dismissSuggestibleProducts()
}

protocol SuggestibleProductsInteractorInterface: InteractorInterface {
    var products : [Product] { get }
    init(products : [Product])
    
    func getSelectedProducts(with indexs : [Int]) -> [Product]
}
