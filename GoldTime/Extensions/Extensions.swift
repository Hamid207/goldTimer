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
