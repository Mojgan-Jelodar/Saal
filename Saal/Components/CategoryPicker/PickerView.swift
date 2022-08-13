//
//  CategoryPickerView.swift
//  Saal
//
//  Created by Mozhgan
//

import UIKit
import Combine
import CombineCocoa
import SnapKit
final class PickerView: UIView,UIContentView {
    
    @Published private(set)  var rowSelectedPublisher : IndexPath?
    
    var configuration: UIContentConfiguration {
        didSet {
            self.setUpConfiguration()
        }
    }
    
    private var categoryPickerViewDataSource : PickerViewDataSource?
    private lazy var pickerView: UIPickerView = {
        UIPickerView()
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
    private var cancellables = Set<AnyCancellable>()
    private func setUpViews() {
        self.addSubview(pickerView)
        self.setConstarints()
    }
    
    private func setConstarints() {
        pickerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    private func setUpConfiguration() {
        guard let configuration = self.configuration as? PickerView.Configuration else { return  }
        categoryPickerViewDataSource =  PickerViewDataSource(items: configuration.items)
        pickerView.dataSource = categoryPickerViewDataSource
        pickerView.delegate = categoryPickerViewDataSource
        binding()
    }
    
    private func binding() {
        self.categoryPickerViewDataSource?
            .$didSelectRowPublisher
            .assign(to: &$rowSelectedPublisher)
    }

}

extension PickerView {
    struct Configuration : UIContentConfiguration {
        private(set) var items : [PickerViewItem]

        init(items : [PickerViewItem]) {
            self.items = items
        }
        
        func makeContentView() -> UIView & UIContentView {
            PickerView(configuration: self)
        }
        
        func updated(for state: UIConfigurationState) -> PickerView.Configuration {
            self
        }
    }
}
