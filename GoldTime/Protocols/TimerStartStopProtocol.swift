//
//  TimerStartStopProtocol.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation

protocol PushTimerDetailVCDelegate: AnyObject {
    func timerStartDelegate(index: Int?, startPauseBool: Bool, bugFixBool: Bool?, secondTimerDontStart: Bool?)
}

protocol TimerStartStopDelegate: AnyObject {
    func timerStartStop(index: Int?, timerCounting: Bool, startTime: Date?, stopStime: Date?)
}

protocol PomodoroTimerStartStopDelegate: AnyObject {
    func pomodoroTimerStartStop(index: Int?, pomodoroStartTime: Date?, pomdoroStopTime: Date?)
}
