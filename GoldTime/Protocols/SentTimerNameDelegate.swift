//
//  SentTimerNameDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 28.01.22.
//

import Foundation

protocol SentTimerNameDelegate: AnyObject {
    func sentTimerName(name: String?)
}

protocol EditTimerNameDelegate: AnyObject {
    func sentNewTimerName(name: String?)
}
