//
//  UIView+SafeArea.swift
//  Blu
//
//  Created by jelodar on 7/19/1400 AP.
//

import UIKit
import SnapKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
            if #available(iOS 11.0, *) {
                return self.safeAreaLayoutGuide.snp
            }
            return self.snp
        #else
            return self.snp
        #endif
    }

}
