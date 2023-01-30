//
//  UIView+Misc.swift
//  MockPosts
//
//  Created by Ruyther Costa on 30/01/23.
//

import UIKit

extension UIView {
    convenience init(translateMask: Bool) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = translateMask
    }
}
