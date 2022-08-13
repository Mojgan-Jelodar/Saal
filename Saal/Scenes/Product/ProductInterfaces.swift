//
//  AddOrUpdateProductInterfaces.swift
//  Saal
//
//  Created by Mozhgan
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Combine

protocol ProductWireframeInterface: WireframeInterface {
    func routeTo(desination : ProductViewController.Desination)
}

protocol ProductMoudleDelegate : AnyObject {
    func productDidUpdated(product:Product)
}

protocol ProductPresenterInterface: PresenterInterface {

}

protocol ProductInteractorInterface: InteractorInterface {
    var product : AnyPublisher<Product?,Never> { get }
    var categories : AnyPublisher<[Category],Never> { get }
    func addProduct(id : String,
                    name : String,
                    description : String?,
                    categoryId: String)
    func deleteRelation(id: String)
    func getSuggestibleProducts() -> AnyPublisher<[Product],Never>
    func addRelations(products: [Product])
}
