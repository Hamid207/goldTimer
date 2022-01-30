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
    func saveTimerColor(color: UIColor?)
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
    private var timerColor: UIColor?
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
        if mon == false && thu == false && wed == false && thu == false && fri == false && sat == false && sun == false {
            timerAllWeekDayFalse = true
            checkNill()
        }else {
            timerAllWeekDayFalse = false
            checkNill()
        }
    }
    
    func saveTimerColor(color: UIColor?){
        if color != nil {
            timerColor = color
        }else {
            timerColor = nil
        }
    }
    
    func saveTimerButton() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let weekday = Calendar.current.component(.weekday, from: date)
        let model = TimerModelData(name: timerName, timerTime: timerTime, timerColor: timerColor, hourse: <#T##Int#>, minute: <#T##Int#>, seconds: <#T##Int#>, statick: <#T##Int#>, pomodoroTime: <#T##Int?#>, pomodoroTimerOnOff: <#T##Bool?#>, pomodorTimerWorkOrBreak: <#T##Bool?#>, startFix: <#T##Bool#>, bugFixBool: <#T##Bool?#>, userTimerstatistics: <#T##Int?#>, startTimer: <#T##Date?#>, stopTimer: <#T##Date?#>, timerCounting: <#T##Bool#>, timerUpdateTime: <#T##Int#>, pomodoroTimerUpdateTime: <#T##Int#>, pomdoroStartTime: <#T##Date?#>, pomdoroStopTime: <#T##Date?#>, todayDate: <#T##String?#>, weekDay: <#T##Int?#>, timer24houresResetOnOff: <#T##Bool#>, mon: <#T##Bool#>, tue: <#T##Bool#>, wed: <#T##Bool#>, thu: <#T##Bool#>, fri: <#T##Bool#>, sat: <#T##Bool#>, sun: <#T##Bool#>, timerDone: <#T##Bool#>)
        print("SAVEE")
    }
    
    func popVC() {
        mainRouter?.popVC()
    }
    
    private func checkNill() {
        if timerTime != nil && timerName != nil && timerAllWeekDayFalse != true {
            saveButtonIsSelected = true
            let indexPosition = IndexPath(row: 0, section: 4)
            tableView?.reloadRows(at: [indexPosition], with: .none)
            print("TRUEE")
        }else {
            saveButtonIsSelected = false
            let indexPosition = IndexPath(row: 0, section: 4)
            tableView?.reloadRows(at: [indexPosition], with: .none)
            print("Falsee")
        }
    }
}
