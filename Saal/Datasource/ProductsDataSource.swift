//
//  ProductsDataSource.swift
//  Saal
//
//  Created by Mozhgan 
//

import Foundation
import UIKit
import Combine

final class ProductsDataSource<T:ProductViewCellActions> : UITableViewDiffableDataSource<ProductsDataSource.Section,
                                                           ProductsDataSource.ItemIdentifier> {
    typealias ViewEvent = T.ViewEvent
    
    private var cancellables = Set<AnyCancellable>()
    
    var actionPublisher: AnyPublisher<ViewEvent, Never> {
        viewEventSubject.eraseToAnyPublisher()
    }
    private var viewEventSubject: PassthroughSubject<ViewEvent, Never> = .init()
    
    convenience init(tableView: UITableView,
                     cellIdentifer: String ) {
        self.init(tableView: tableView,
                  cellProvider: { (tableView,indexPath,viewModel) in
            let product = viewModel.product
            let productActions = T.init(product: product)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
            cell.selectionStyle = .none
            cell.contentConfiguration = ProductView<ProductViewItem, T>.Configuration(productViewItem: product, productActions: productActions)
            return cell
        })
    }
    
    func update(with list: [ProductViewItem], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<ProductsDataSource.Section,
                                                    ProductsDataSource.ItemIdentifier>()
        snapshot.appendSections([Section.list])
        snapshot.appendItems(list.map { ItemIdentifier.list($0)}, toSection: .list)
        self.apply(snapshot, animatingDifferences: true)
    }
    
    func delete(with product: ProductViewItem, animate: Bool = true) {
        let viewModel = ProductsDataSource.ItemIdentifier.list(product)
        var snapshot = self.snapshot()
        snapshot.deleteItems([viewModel])
        apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let productView = cell.contentView as? ProductView<ProductViewItem,T>
        let configuration = productView?.configuration as? ProductView<ProductViewItem, T>.Configuration<ProductViewItem,T>
        configuration?.productActions?.actionPublisher.sink(receiveValue: { [weak self] viewEvent in
            guard let self = self else {
                return
            }
            self.viewEventSubject.send(viewEvent)
        }).store(in: &cancellables)
        return cell
    }
    
}
extension ProductsDataSource {
    enum ItemIdentifier: Hashable {
        case list(ProductViewItem)
        var product: ProductViewItem {
            switch self {
            case .list(let product):
                return  product
            }
        }
    }
    
    enum Section {
        case list
    }
}
