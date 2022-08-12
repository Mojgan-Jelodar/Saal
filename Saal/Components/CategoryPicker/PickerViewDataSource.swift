//
//  PickerViewDataSource.swift
//  Saal
//
//  Created by Mozhgan on 8/11/22.
//

import Foundation
import Combine
import UIKit


protocol PickerViewDataSourceDelegate {
    var items : [PickerViewItem] { get }
    var numberOfComponents :Int { get}
    init(items : [PickerViewItem])
}

final class PickerViewDataSource : NSObject,PickerViewDataSourceDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var items: [PickerViewItem]
    
    @Published private(set) var didSelectRowPublisher : IndexPath?
    
    var numberOfComponents: Int {
        return 1
    }
    
    init(items: [PickerViewItem]) {
        self.items = items
        guard let index = items.firstIndex(where: {$0.isSelected}) else { return }
        didSelectRowPublisher = .init(row: index, section: .zero)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items.title(for: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectRowPublisher = .init(row: row, section: component)
    }
}
