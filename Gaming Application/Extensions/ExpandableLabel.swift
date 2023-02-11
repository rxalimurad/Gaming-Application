//
//  ExpandableLabel.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import UIKit

class ExpandableLabel :UILabel {
    //MARK: - Properties
    var isExpaded = false
    let lineThreshold = 4
    //MARK: - Life Cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let buttonAray =  self.superview?.subviews.filter({ (subViewObj) -> Bool in
            return subViewObj.tag ==  9090
        })
        if buttonAray?.isEmpty == true {
            self.addReadMoreButton()
        }
    }
    //MARK: - Add Read more button if Needed
    func addReadMoreButton() {
        let theNumberOfLines = numberOfLinesInLabel(yourString: self.text ?? "", labelWidth: self.frame.width, labelHeight: self.frame.height, font: self.font)
        let height = self.frame.height
        self.numberOfLines =  self.isExpaded ? 0 : lineThreshold
        
        if theNumberOfLines > lineThreshold {
            self.numberOfLines = lineThreshold
            let button = UIButton(frame: CGRect(x: 0, y: height + 20, width: 70, height: 15))
            button.tag = 9090
            button.frame = self.frame
            button.frame.origin.y =  self.frame.origin.y + self.frame.size.height + 15
            button.setTitle("Read more", for: .normal)
            button.titleLabel?.font = button.titleLabel?.font.withSize(12)
            button.backgroundColor = .clear
            button.setTitleColor(UIColor.blue, for: .normal)
            button.addTarget(self, action: #selector(ExpandableLabel.buttonTapped(sender:)), for: .touchUpInside)
            self.superview?.addSubview(button)
            self.superview?.bringSubviewToFront(button)
            button.setTitle("Read less", for: .selected)
            button.isSelected = self.isExpaded
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 20),
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                button.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: 20)
            ])
        }else{
            
            self.numberOfLines = lineThreshold
        }
    }
    
    //MARK: - Calculate Number of line
    func numberOfLinesInLabel(yourString: String, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = labelHeight
        paragraphStyle.maximumLineHeight = labelHeight
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font, NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue): paragraphStyle]
        let constrain = CGSize(width: labelWidth, height: CGFloat(Float.infinity))
        let size = yourString.size(withAttributes: attributes)
        let stringWidth = size.width
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        return Int(numberOfLines)
    }
    
    //MARK: - ReadMore Button Action
    @objc func buttonTapped(sender : UIButton) {
        self.isExpaded = !isExpaded
        sender.isSelected =   self.isExpaded
        self.numberOfLines =  sender.isSelected ? 0 : lineThreshold
        self.layoutIfNeeded()
        var viewObj :UIView?  = self
        var cellObj :UITableViewCell?
        while viewObj?.superview != nil  {
            if let cell = viewObj as? UITableViewCell  {
                cellObj = cell
            }
            if let tableView = (viewObj as? UITableView)  {
                if let indexPath = tableView.indexPath(for: cellObj ?? UITableViewCell()){
                    tableView.beginUpdates()
                    print(indexPath)
                    tableView.endUpdates()
                }
                return
            }
            viewObj = viewObj?.superview
        }
    }
}
