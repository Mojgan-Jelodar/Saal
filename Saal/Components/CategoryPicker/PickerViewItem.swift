import UIKit


final class PickerViewItem {
    internal var id: String?
    private(set) var name: String
    private(set) var isSelected : Bool

    init(
        id: String?,
        name: String,
        isSelected : Bool
    ) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}

// MARK: - CategoryPickerItem

extension PickerViewItem: PickerItem {
    var title: String { name }
}


extension Array where Element : PickerItem {
    func title(for index : Int) -> String {
        return self[index].title
    }
}
