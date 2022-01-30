//
//  SaveWeekDayDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 29.01.22.
//

import Foundation

protocol SaveWeekDayDelegate: AnyObject {
    func saveWeekDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool)
}
