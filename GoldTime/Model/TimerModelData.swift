//
//  TimerModelData.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import RealmSwift

class TimerModelData: Object {
    @Persisted var name: String?
    @Persisted var index: Int
    @Persisted var timerTime: Int
    @Persisted var editTimerTime: Int? = nil
    @Persisted var editTimerTimeBool: Bool = false
    @Persisted var timerColor: String?
    @Persisted var timerColorIndex: Int? = 0
    @Persisted var hourse: Int
    @Persisted var minute: Int
    @Persisted var seconds: Int
    @Persisted var statick: Int
    @Persisted var pomodoroTime: Int?
    @Persisted var pomodoroTimerOnOff: Bool?
    @Persisted var pomodorTimerWorkOrBreak: Bool?
    @Persisted var startFix: Bool
    @Persisted var bugFixBool: Bool?
    @Persisted var userTimerstatistics: Int?
    @Persisted var startTimer: Date?
    @Persisted var stopTimer: Date?
    @Persisted var timerCounting: Bool
    @Persisted var timerUpdateTime: Int
    @Persisted var pomodoroTimerUpdateTime: Int
    @Persisted var pomdoroStartTime: Date?
    @Persisted var pomdoroStopTime: Date?
    @Persisted var timerStatistics = Map<String, Int>()
    @Persisted var theTimerIsFinishedHowManyTimes: Int = 0
    @Persisted var timerDone: Bool
    @Persisted var timerDoneDate: String?
    @Persisted var timerautomaticallyStopAneRelaoad: String?
    @Persisted var todayDate: String?
    @Persisted var weekDay: Int?
    @Persisted var timer24houresResetOnOff: Bool
    @Persisted var Mon: Bool
    @Persisted var Tue: Bool
    @Persisted var Wed: Bool
    @Persisted var Thu: Bool
    @Persisted var Fri: Bool
    @Persisted var Sat: Bool
    @Persisted var Sun: Bool
    @Persisted var timerStartToDay: Bool = false
    @Persisted var userTarget: Int?
    
//    @Persisted var test = List<tests>()
        
    convenience init(name: String?, timerTime: Int, timerColor: String?, hourse: Int, minute: Int, seconds: Int, statick: Int, pomodoroTime: Int?, pomodoroTimerOnOff: Bool?, pomodorTimerWorkOrBreak: Bool?, startFix: Bool, bugFixBool: Bool?, userTimerstatistics: Int?, startTimer: Date?, stopTimer: Date?, timerCounting: Bool, timerUpdateTime: Int, pomodoroTimerUpdateTime: Int, pomdoroStartTime: Date?, pomdoroStopTime: Date?, todayDate: String?, weekDay: Int?, timer24houresResetOnOff: Bool, mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool, timerDone: Bool, timerColorIndex: Int?, userTarget: Int?) {
        self.init()
        self.name = name
        self.timerTime = timerTime
        self.timerColor = timerColor
        self.hourse = hourse
        self.minute = minute
        self.seconds = seconds
        self.statick = statick
        self.pomodoroTime = pomodoroTime
        self.pomodoroTimerOnOff = pomodoroTimerOnOff
        self.pomodorTimerWorkOrBreak = pomodorTimerWorkOrBreak
        self.startFix = startFix
        self.bugFixBool = bugFixBool
        self.userTimerstatistics = userTimerstatistics
        self.startTimer = startTimer
        self.stopTimer = stopTimer
        self.timerCounting = timerCounting
        self.timerUpdateTime = timerUpdateTime
        self.pomodoroTimerUpdateTime = pomodoroTimerUpdateTime
        self.pomdoroStartTime = pomdoroStartTime
        self.pomdoroStopTime = pomdoroStopTime
        self.todayDate = todayDate
        self.weekDay = weekDay
        self.timer24houresResetOnOff = timer24houresResetOnOff
        self.Mon = mon
        self.Tue = tue
        self.Wed = wed
        self.Thu = thu
        self.Fri = fri
        self.Sat = sat
        self.Sun = sun
        self.timerDone = timerDone
        self.timerColorIndex = timerColorIndex
        self.userTarget = userTarget
    }
}

//class tests: Object {
//    @Persisted var Mon: Bool
//}
