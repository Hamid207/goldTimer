//
//  SentTimerTimeDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 28.01.22.
//

import Foundation

protocol SentTimerTimeDelegate: AnyObject {
    func sentTimerTime(h: Int, m: Int)
}
