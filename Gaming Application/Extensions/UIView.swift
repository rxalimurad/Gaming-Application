//
//  UIView.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import UIKit
extension UIView {
    func setConstraints(with parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    }
    
    func addGradient(color1: UIColor, color2: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
}
