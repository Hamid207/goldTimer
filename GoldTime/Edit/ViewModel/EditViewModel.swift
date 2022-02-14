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
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?, timerModel: TimerModelData?, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.index = index
        self.day = day
        self.col = col
        model = timerModel
        timerName = model?.name
        sentPredicate(predicate: predicate)
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
        if day != 1 {
            try! realm.write {
                dataStore?.timerArray?[index].Mon = mon
            }
        }else {
            editWeekDay = 1
        }
        if day != 2 {
            try! realm.write {
                dataStore?.timerArray?[index].Tue = tue
            }
        }else {
            editWeekDay = 2
        }
        if day != 3 {
            try! realm.write {
                dataStore?.timerArray?[index].Wed = wed
            }
        }else {
            editWeekDay = 3
        }
        if day != 4 {
            try! realm.write {
                dataStore?.timerArray?[index].Thu = thu
            }
        }else {
            editWeekDay = 4
        }
        if day != 5 {
            try! realm.write {
                dataStore?.timerArray?[index].Fri = fri
            }
        }else {
            editWeekDay = 5
        }
        if day != 6 {
            try! realm.write {
                dataStore?.timerArray?[index].Sat = sat
            }
        }else {
            editWeekDay = 6
        }
        if day != 7 {
            try! realm.write {
                dataStore?.timerArray?[index].Sun = sun
            }
        }else {
            editWeekDay = 7
        }
        
        
        switch editWeekDay {
            case 1:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                try! realm.write {
                    dataStore?.timerArray?[index].Mon = mon
                }
            case 2:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                
                try! realm.write {
                    dataStore?.timerArray?[index].Tue = tue
                }
            case 3:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                
                try! realm.write {
                    dataStore?.timerArray?[index].Wed = wed
                }
            case 4:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                
                try! realm.write {
                    dataStore?.timerArray?[index].Thu = thu
                }
            case 5:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                
                try! realm.write {
                    dataStore?.timerArray?[index].Fri = fri
                }
            case 6:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                
                try! realm.write {
                    dataStore?.timerArray?[index].Sat = sat
                }
            case 7:
                if dataStore?.timerArray?[index].timerCounting == true {
                    let cell = col.cellForItem(at: [0,index]) as! MainCollectionViewCelll
                    cell.stopInEdit()
                }
                
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
