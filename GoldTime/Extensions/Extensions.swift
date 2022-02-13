//
//  Extensions.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import UIKit
extension Date {
   func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: self)
    }
    
    func getFormattedDateTime() -> String {
         let dateformat = DateFormatter()
         dateformat.dateFormat = "MM-dd-yyyy HH:mm"
         return dateformat.string(from: self)
     }
}

extension Date {
    var startOfDay : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
   }

    var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }
    
    var yesterdayEndOfDay : Date {
        var components = DateComponents()
        components.day = 0
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(0))!
    }
    
    var yesterdayEndOfDayNeedFormat : Date {
        var components = DateComponents()
        components.day = -1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(0))!
    }
}

extension UIPickerView {
    
    func setPickerLabels(labels: [Int:UILabel], containedView: UIView) { // [component number:label]
        let fontSize:CGFloat = 20
        let labelWidth:CGFloat = containedView.bounds.width / CGFloat(self.numberOfComponents)
        let x:CGFloat = self.frame.origin.x
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)

        for i in 0...self.numberOfComponents {

            if let label = labels[i] {

                if self.subviews.contains(label) {
                    label.removeFromSuperview()
                }

                label.frame = CGRect(x: x + labelWidth * CGFloat(i), y: y, width: labelWidth, height: fontSize)
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.backgroundColor = .clear
                label.textAlignment = NSTextAlignment.left

                self.addSubview(label)
            }
        }
    }
}

extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
 }

extension NSNumber {
    func getPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0 // You can set what you want
        return formatter.string(from: self)!
    }
}

extension String {
    func PadLeft( totalWidth: Int,byString:String) -> String {
        let toPad = totalWidth
        if toPad < 1 {
            return self
        }
        
        return "".padding(toLength: toPad, withPad: byString, startingAt: 1) + self
        
    }
}

