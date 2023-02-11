//
//  WrappedButton.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import UIKit
class WrappedButton: UIButton {
    override var titleEdgeInsets: UIEdgeInsets {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        var sizeWithInsets = titleLabel?.intrinsicContentSize ?? super.intrinsicContentSize
        sizeWithInsets.width += titleEdgeInsets.left + titleEdgeInsets.right
        sizeWithInsets.height += titleEdgeInsets.top + titleEdgeInsets.bottom
        return sizeWithInsets
    }
}
