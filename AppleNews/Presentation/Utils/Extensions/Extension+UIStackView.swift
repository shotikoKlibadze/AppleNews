//
//  Extension+UIStackView.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
}
