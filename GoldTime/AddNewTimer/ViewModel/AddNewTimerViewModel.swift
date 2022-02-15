//
//  AddNewTimerViewModel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

protocol AddNewTimerViewModelProtocol {
    var tableView: UITableView? { get set }
    func saveTimer(timer: TimerModelData)
    func popVC()
    func saveTimerName(name: String?)
    func saveTimerTime(hourse: Int?, minute: Int?)
    func saveTimerWeekDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool)
    func saveTimerColor(color: String?, colorIndex: Int)
    func saveTimerButton()
    var saveButtonIsSelected: Bool! { get set }
    init(mainRouter: MainRouterProtocol?, timerTimerArray: TimerTimeArrayProtocol?, dataStore: DataStoreProtocol?)
}

final class AddNewTimerViewModel: AddNewTimerViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    private var timerTimerArray: TimerTimeArrayProtocol?
    private let dataStore: DataStoreProtocol?
    var tableView: UITableView?
//    private let timerName: String?
    private lazy var mon = false
    private lazy var tue = false
    private lazy var wed = false
    private lazy var thu = false
    private lazy var fri = false
    private lazy var sat = false
    private lazy var sun = false
    private var timerName: String?
    private var timerTime: Int?
    private var timerColor: String?
    private var timerColorIndex: Int?
    private var timerAllWeekDayFalse = false
    var saveButtonIsSelected: Bool! = false
    init(mainRouter: MainRouterProtocol?, timerTimerArray: TimerTimeArrayProtocol?, dataStore: DataStoreProtocol?) {
        self.mainRouter = mainRouter
        self.timerTimerArray = timerTimerArray
        self.dataStore = dataStore
    }
    
    func saveTimer(timer: TimerModelData) {
        dataStore?.saveObject(timer)
    }
    
    func saveTimerName(name: String?){
        if name != "" {
            timerName = name
            checkNill()
        }else {
            timerName = nil
            checkNill()
        }
    }
    
    func saveTimerTime(hourse: Int?, minute: Int?){
        if hourse == 0 && minute == 0 {
            timerTime = nil
            checkNill()
        }else {
            let timeee = hourse! * 3600 + minute! * 60
            timerTime = timeee
            checkNill()
        }
    }
    
    func saveTimerWeekDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool) {
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
        self.sat = sat
        self.sun = sun
        if mon == false && tue == false && wed == false && thu == false && fri == false && sat == false && sun == false {
            timerAllWeekDayFalse = true
            checkNill()
        }else {
            timerAllWeekDayFalse = false
            checkNill()
        }
    }
    
    func saveTimerColor(color: String?, colorIndex: Int){
        if color != nil {
            timerColor = color
            timerColorIndex = colorIndex
        }else {
            timerColor = nil
            timerColorIndex = nil
        }
    }
    
    func saveTimerButton() {
                let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                let weekday = Calendar.current.component(.weekday, from: date)
                guard let time = timerTime else { return }
        let model = TimerModelData(name: timerName, timerTime: time, timerColor: timerColor, hourse: 0, minute: 0, seconds: 0, statick: time, pomodoroTime: nil, pomodoroTimerOnOff: nil, pomodorTimerWorkOrBreak: nil, startFix: false, bugFixBool: false, userTimerstatistics: 0, startTimer: nil, stopTimer: nil, timerCounting: false, timerUpdateTime: time, pomodoroTimerUpdateTime: 0, pomdoroStartTime: nil, pomdoroStopTime: nil, todayDate: Date().getFormattedDate(), weekDay: weekday, timer24houresResetOnOff: false, mon: mon, tue: tue, wed: wed, thu: thu, fri: fri, sat: sat, sun: sun, timerDone: false, timerColorIndex: timerColorIndex)
                dataStore?.saveObject(model)
        popVC()
    }
    
    func popVC() {
        mainRouter?.popVC()
    }
    
    private func checkNill() {
        if timerTime != nil && timerName != nil && timerAllWeekDayFalse != true {
            saveButtonIsSelected = true
            let indexPosition = IndexPath(row: 0, section: 4)
            tableView?.reloadRows(at: [indexPosition], with: .none)
//            print("TRUEE AddNEWTIMER ViewMODEl 120")
        }else {
            saveButtonIsSelected = false
            let indexPosition = IndexPath(row: 0, section: 4)
            tableView?.reloadRows(at: [indexPosition], with: .none)
//            print("Falsee AddNEWTIMER ViewMODEl 120")
        }
    }
}
