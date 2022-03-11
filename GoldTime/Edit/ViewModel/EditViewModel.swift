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
    var timerStartToDay: Bool! { get set }
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?, timerModel: TimerModelData?, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView)
}

final class EditViewModel: EditViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    private var dataStore: DataStoreProtocol?
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
    private lazy var editWeekDay = Int()
    private var timerName: String?
    private var timerTime: Int?
    private var timerColor: String?
    private var timerColorIndex: Int?
    private var timerAllWeekDayFalse = false
    var saveButtonIsSelected: Bool! = false
    private lazy var day = Int()
    var col: UICollectionView!
    var timerStartToDay: Bool! = false
    private let region = Locale.current.regionCode
    private lazy var calendarRegion = false
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?, timerModel: TimerModelData?, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.index = index
        self.day = day
        self.col = col
        model = timerModel
        timerName = model?.name
        sentPredicate(predicate: predicate)
        timerStartToDay = dataStore?.timerArray?[index].timerStartToDay
    }
    
    private func sentPredicate(predicate: NSPredicate) {
        dataStore?.predicateFilter(predicate: predicate)
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
            //            print("TIMER TIME 111 === \(dataStore?.timerArray?[index].timerTime) -- newtime 111 === \(timerTime)")
            
            if dataStore?.timerArray?[index].timerTime != timerTime {
                //                print("TIMER TIME 222 === \(dataStore?.timerArray?[index].timerTime) -- newtime 222 === \(timerTime)")
                dataStore?.timerArray?[index].editTimerTime = timerTime!
                dataStore?.timerArray?[index].editTimerTimeBool = true
            }
            if timerColor != nil {
                dataStore?.timerArray?[index].timerColor = timerColor
                dataStore?.timerArray?[index].timerColorIndex = timerColorIndex
            }
            
        }
        
        //gunleri edit edende eger bu gun MONday idise sende MONdayden girib MONdayi false eliyende crash olurdu - realm osaniye updaye elediyi birde Realm filter olundugu ucun index nil verirdi - helli helki beledi sora duzelt
        if region == "US" || region == "CA" {
            calendarRegion = true
        }
        
        let monDay = calendarRegion ? 2 : 1
        let tueDay = calendarRegion ? 3 : 2
        let wedDay = calendarRegion ? 4 : 3
        let thuday = calendarRegion ? 5 : 4
        let friDay = calendarRegion ? 6 : 5
        let satDay = calendarRegion ? 7 : 6
        let sunDay = calendarRegion ? 1 : 7
        
        if day != monDay {
            try! realm.write {
                dataStore?.timerArray?[index].Mon = mon
            }
        }else {
            editWeekDay = monDay
        }
        if day != tueDay {
            try! realm.write {
                dataStore?.timerArray?[index].Tue = tue
            }
        }else {
            editWeekDay = tueDay
        }
        if day != wedDay {
            try! realm.write {
                dataStore?.timerArray?[index].Wed = wed
            }
        }else {
            editWeekDay = wedDay
        }
        if day != thuday {
            try! realm.write {
                dataStore?.timerArray?[index].Thu = thu
            }
        }else {
            editWeekDay = thuday
        }
        if day != friDay {
            try! realm.write {
                dataStore?.timerArray?[index].Fri = fri
            }
        }else {
            editWeekDay = friDay
        }
        if day != satDay {
            try! realm.write {
                dataStore?.timerArray?[index].Sat = sat
            }
        }else {
            editWeekDay = satDay
        }
        if day != sunDay {
            try! realm.write {
                dataStore?.timerArray?[index].Sun = sun
            }
        }else {
            editWeekDay = sunDay
        }
        

        switch editWeekDay {
            case monDay:
                try! realm.write {
                    dataStore?.timerArray?[index].Mon = mon
                }
            case tueDay:
                try! realm.write {
                    dataStore?.timerArray?[index].Tue = tue
                }
            case wedDay:
                try! realm.write {
                    dataStore?.timerArray?[index].Wed = wed
                }
            case thuday:
                try! realm.write {
                    dataStore?.timerArray?[index].Thu = thu
                }
            case friDay:
                try! realm.write {
                    dataStore?.timerArray?[index].Fri = fri
                }
            case satDay:
                try! realm.write {
                    dataStore?.timerArray?[index].Sat = sat
                }
            case sunDay:
                try! realm.write {
                    dataStore?.timerArray?[index].Sun = sun
                }
            default:
                break
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
