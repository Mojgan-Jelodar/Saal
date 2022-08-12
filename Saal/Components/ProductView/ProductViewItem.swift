//
//  ProductViewItem.swift
//  Saal
//
//  Created by Mozhgan
//

import Foundation
protocol ProductViewItemProtocol : CustomStringConvertible,Hashable  {
    var categoryName: String { get }
    var id: String { get }
    var name : String { get }
    var comment : String { get }
}
extension ProductViewItemProtocol  {
    var description: String {
        [self.categoryName,self.name].joined(separator: "-")
    }
}

struct ProductViewItem : ProductViewItemProtocol {
    
    let id: String
    
    let categoryName: String
    
    let name: String
    
    let comment: String
}
