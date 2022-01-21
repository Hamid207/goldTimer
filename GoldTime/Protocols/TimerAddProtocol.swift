//
//  TimerAddProtocol.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation

protocol TimerItemAddDelegate: AnyObject {
    func timerAdd(timer: TimerModelData)
}
