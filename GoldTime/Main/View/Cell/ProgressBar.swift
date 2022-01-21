//
//  ProgressBar.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit
import Foundation

class ProgressBar: UIView {
    
    private var bacroundLayer: CAShapeLayer!
    private var foregRoundLayer: CAShapeLayer!
    private var texLayer: CATextLayer!
    private var timerSecondsLayer: CGFloat!
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")

    public var progress: CGFloat = 0 {
        didSet {
//            didProgressUpdate()
        }
    }

    override func layoutSubviews() {
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let lineWidth = 0.03 * min(width, height)
        
        bacroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.white.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        foregRoundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.black.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        //        foregroundLayer.strokeEnd = 0.9
        
        layer.addSublayer(bacroundLayer)
        layer.addSublayer(foregRoundLayer)
    }
    
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let width = rect.width
        let height = rect.height
        
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(height, width) - lineWidth) / 2.2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        return shapeLayer
    }
    
    func basicAnimationFunc() {
//        foregRoundLayer.strokeEnd = CGFloat(0.90)
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(9)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregRoundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func firstAnimation(value: Float) {
//        let aaa = String(format:"%.02f", Float(27 * 100) / 500)
        let aaa = 27 * 100 / 500
        print(aaa)
        var bbb = Float(aaa)
        print("TEst11 = \(String(format: "%2d.%2d", 0, 55))")
        let ii = String(format: "%02d.%02d", 0,aaa)
        let bbbb = String(format: "%.0f:%0f", 0,aaa)
        print("iii = \(Float(ii))")
//        let aa = Float(ii!)
        basicAnimation.duration = 0
        basicAnimation.toValue = 0.70
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregRoundLayer.strokeEnd = CGFloat(Float(0.70))
        foregRoundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func pauseAnimation(){
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeAnimation(){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

    
    //MARK: - Progress Bar
//    override func draw(_ rect: CGRect) {
//        let width = rect.width
//        let height = rect.height
//
//        let lineWidth = 0.03 * min(width, height)
//
//        bacroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
//
//
//        foregRoundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
//
//        texLayer = createTextLayer(rect: rect, textColor: UIColor.white.cgColor)
//
////        foregRoundLayer.strokeEnd = 0.5
////        print(foregRoundLayer.strokeEnd)
//
//
//        layer.addSublayer(bacroundLayer)
//        layer.addSublayer(foregRoundLayer)
//        layer.addSublayer(texLayer)
//
//    }
//
//    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
//        let width = rect.width
//        let height = rect.height
//
//        let center = CGPoint(x: width / 2, y: height / 2)
//        let radius = (min(width, height) - lineWidth) / 2
//
//        let startAngle = -CGFloat.pi / 2
//        let endAngle = startAngle + 2 * CGFloat.pi
//
//
//        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle , clockwise: true)
//
//        let shapeLayer = CAShapeLayer()
//
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = strokeColor
//        shapeLayer.fillColor = fillColor
//        shapeLayer.lineWidth = lineWidth
//        shapeLayer.lineCap = .round
//
//        return shapeLayer
//    }
//
//    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
//        let width = rect.width
//        let height = rect .height
//
//        let fontSize = min(width, height) / 4
//        let offSet = min(width, height) * 0.1
//
//        let layer = CATextLayer()
//        layer.string = "100"
//        layer.backgroundColor = UIColor.clear.cgColor
//        layer.foregroundColor = textColor
//        layer.fontSize = fontSize
//        layer.frame = CGRect(x: 0, y: (height - fontSize - offSet) / 2, width: width, height: fontSize + offSet)
//        layer.alignmentMode = .center
//
//        return layer
//    }
//
//    private func didProgressUpdate() {
//        texLayer?.string = "\(Int(progress * 20))"
//        foregRoundLayer?.strokeEnd = progress
//    }
//
//        private func basicAnimation() {
//            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//            basicAnimation.toValue = 0
//            basicAnimation.duration = CFTimeInterval(timerSecondsLayer)
//            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
//            basicAnimation.isRemovedOnCompletion = false
//            foregRoundLayer.add(basicAnimation, forKey: "basicAnimation")
//        }
//
//        func pauseAnimation(){
//            let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
//            layer.speed = 0.0
//            layer.timeOffset = pausedTime
//        }
//
//        func resumeAnimation(){
//            let pausedTime = layer.timeOffset
//            layer.speed = 1.0
//            layer.timeOffset = 0.0
//            layer.beginTime = 0.0
//            let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//            layer.beginTime = timeSincePause
//        }

}
