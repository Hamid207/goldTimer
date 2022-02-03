//
//  EditViewModel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 30.01.22.
//

import UIKit

protocol EditViewModelProtocol{
    func popVC()
    var model: TimerModelData? { get set }
    var tableView: UITableView? { get set }
    func saveTimerName(name: String?)
    func saveTimerTime(hourse: Int?, minute: Int?)
    func saveTimerWeekDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool)
    func saveTimerColor(color: String?, colorIndex: Int)
    func saveTimerButton()
    var saveButtonIsSelected: Bool! { get set }
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?, timerModel: TimerModelData?, index: Int)
}

final class EditViewModel: EditViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    private let dataStore: DataStoreProtocol?
    var tableView: UITableView?
    var model: TimerModelData?
    private var index: Int?
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
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?, timerModel: TimerModelData?, index: Int) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.index = index
        model = timerModel
        timerName = model?.name
    }
    
    func saveTimerName(name: String?) {
        if name != "" {
            timerName = name
            checkNill()
        }else {
            timerName = nil
            checkNill()
        }
    }
    
    func saveTimerTime(hourse: Int?, minute: Int?) {
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
    
    func saveTimerColor(color: String?, colorIndex: Int) {
        if color != nil {
            timerColor = color
            timerColorIndex = colorIndex
        }        else {
            timerColor = nil
            timerColorIndex = nil
        }
    }
    
    func saveTimerButton() {
        guard let index = index else { return }
        try! realm.write {
            dataStore?.timerArray?[index].name = timerName
            print("TIMER TIME 111 === \(dataStore?.timerArray?[index].timerTime) -- newtime 111 === \(timerTime)")

            if dataStore?.timerArray?[index].timerTime != timerTime {
                print("TIMER TIME 222 === \(dataStore?.timerArray?[index].timerTime) -- newtime 222 === \(timerTime)")
                dataStore?.timerArray?[index].editTimerTime = timerTime!
                dataStore?.timerArray?[index].editTimerTimeBool = true
            }
            dataStore?.timerArray?[index].Mon = mon
            dataStore?.timerArray?[index].Tue = tue
            dataStore?.timerArray?[index].Wed = wed
            dataStore?.timerArray?[index].Thu = thu
            dataStore?.timerArray?[index].Fri = fri
            dataStore?.timerArray?[index].Sat = sat
            dataStore?.timerArray?[index].Sun = sun
            if timerColor != nil {
                dataStore?.timerArray?[index].timerColor = timerColor
                dataStore?.timerArray?[index].timerColorIndex = timerColorIndex
            }
        }
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
