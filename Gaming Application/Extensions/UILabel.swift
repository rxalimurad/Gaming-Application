//
//  UILabel.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import UIKit

extension UILabel {

    func setHtmlText(html: String) {
        let data = Data(html.utf8)
        if let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            let fontAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(fontAttribute, range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
        } else {
            text = ""
        }
        lineBreakMode = .byTruncatingTail
        adjustsFontSizeToFitWidth = false
    }
    
}
