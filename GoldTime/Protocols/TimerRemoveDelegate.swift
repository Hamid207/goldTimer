//
//  TimerRemoveDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation

protocol TimerRemoveDelegate: AnyObject {
    func removeIndex(modelIndex: TimerModelData, deleteBool: Bool, cellIndex: Int)
}
