//
//  SetTimerUpdateTimeDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation

protocol SetTimerUpdateTimeDelegate: AnyObject {
    func setTimerNewTime(newTime: Int, index: Int)
}

protocol SetPomdoroTimerUpdateTimeDelegate: AnyObject {
    func setPomodoroNewTime(newTime: Int, pomdoroTimerBreakOrWork: Bool, index: Int)
}
