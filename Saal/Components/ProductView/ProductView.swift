//
//  ProductView.swift
//  Saal
//
//  Created by Mozhgan
//

import UIKit
import Combine

fileprivate extension Layout {
    static let buttonSize = 40.0
}

final class ProductView<T: ProductViewItemProtocol,S: ProductViewCellActions>: UIView,UIContentView {
    
    var configuration: UIContentConfiguration {
        didSet {
            self.setUpConfiguration()
        }
    }
    
    private lazy var holderView : UIView = {
        let holderView = UIView(frame: .zero)
        holderView.backgroundColor = .secondarySystemBackground
        return holderView
    }()
    
    private lazy var headerLabel : UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: headerLabel.font.pointSize, weight: .bold)
        headerLabel.numberOfLines = .zero
        headerLabel.lineBreakMode = .byWordWrapping
        return headerLabel
    }()
    
    private lazy var productDescriptionLabel : UILabel = {
        let productDescriptionLabel = UILabel()
        productDescriptionLabel.font = .systemFont(ofSize: headerLabel.font.pointSize, weight: .regular)
        productDescriptionLabel.numberOfLines = 1
        productDescriptionLabel.lineBreakMode = .byTruncatingTail
        return productDescriptionLabel
    }()
    
    private lazy var actionButton : UIButton = {
        let actionButton = UIButton(type: .custom)
        actionButton.setImage(.init(named: "ellipsis.circle"), for: .normal)
        actionButton.showsMenuAsPrimaryAction = true
        return actionButton
    }()
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setUpViews()
        setUpConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(holderView)
        holderView.addSubview(actionButton)
        holderView.addSubview(headerLabel)
        holderView.addSubview(productDescriptionLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        holderView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Layout.padding4)
        }
        actionButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(Layout.buttonSize)
        }
        headerLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Layout.padding8)
            make.trailing.equalTo(actionButton.snp.leading).offset(-Layout.padding8)
        }
        productDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.trailing.equalTo(headerLabel.snp.trailing)
            make.bottom.equalToSuperview().offset(-Layout.padding8)
            make.top.equalTo(headerLabel.snp.bottom).offset(Layout.padding8)
        }
    }
    
    private func setUpConfiguration() {
        guard let configuration = self.configuration as? ProductView.Configuration<T,S> else { return  }
        let data = configuration.productViewItem
        let actions = configuration.productActions
        self.headerLabel.text = data.description
        self.productDescriptionLabel.text = data.comment
        self.actionButton.menu = UIMenu(title: R.string.common.actionTitle(), children: actions?.actions ?? [])
        self.actionButton.isHidden = actions?.actions == nil
    }
}
extension ProductView {
    struct Configuration<T: ProductViewItemProtocol,S: ProductViewCellActions> : UIContentConfiguration {
        
        let productActions : S?
        let productViewItem : T
        
        init(
            productViewItem: T,
            productActions : S? = nil
        ) {
            self.productViewItem = productViewItem
            self.productActions = productActions
        }
        
        func makeContentView() -> UIView & UIContentView {
            ProductView(configuration: self)
        }
        
        func updated(for state: UIConfigurationState) -> ProductView.Configuration<T, S> {
            self
        }
    }
}
