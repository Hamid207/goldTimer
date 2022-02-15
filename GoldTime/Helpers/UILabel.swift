//
//  UILabel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

extension UILabel {
    convenience init(text: String?, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
