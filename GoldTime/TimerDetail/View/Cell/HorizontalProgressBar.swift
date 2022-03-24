//
//  PlainHorizontalProgressBar.swift
//  GoldTime
//
//  Created by Hamid Manafov on 24.03.22.
//

import UIKit

class HorizontalProgressBar: UIView {
    var color: String? = "#15C08E" 
    
    private let progressLayer = CALayer()

    
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        layer.cornerRadius = 5
    }
  
    func updateColor(newColor: String) {
        color = newColor
    }
    
    override func draw(_ rect: CGRect) {
       let bacroundMask = CAShapeLayer()
        bacroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.15).cgPath
        layer.mask = bacroundMask
        
        let pregresRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
//        let progressLayer = CALayer()
        progressLayer.frame = pregresRect
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = UIColor().hexStringToUIColor(hex: color!).cgColor
    }
    
}
