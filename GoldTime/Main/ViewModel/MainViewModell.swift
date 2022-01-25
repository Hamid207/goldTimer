//
//  MainViewModell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import RealmSwift
//main
protocol MainViewModellProtocol {
    func tapTHeAddNewTimerVc()
    func tapOnTheTimerDetailVc(index: Int)
    var index: Int? { get set }
    var timerCounting: Bool? { get set }
    var model: Results<TimerModelData>? { get set }
    var collectionView: UICollectionView? { get set }
    var weekDayCollectionView: UICollectionView? { get set }
    func timerStartStop(timerCounting: Bool, index: Int?, startTime: Date?, stopTime: Date?)
    func remiveTest()
    func timerTimeUpdate(timerTimeUpdate: Int, index: Int?)
    func pomodoroTimeUpdate(newTime: Int, pomdoroTimerBreakOrWork: Bool, index: Int)
    func timerRemove(modelIndex: TimerModelData, removeBool: Bool, index: Int, view: UIViewController, collectionView: UICollectionView)
    func pomdoroStartStopTime(index: Int?, pomdoroStartTime: Date?, pomdoroStopTime: Date?)
    func setIndex(index: Int?)
    var weekDayArray: [String]? { get set }
    var tapWeekDayArray: [Int : Bool]? { get set }
    func sentPredicate(predicate: NSPredicate)
    var predicateRepeat: NSPredicate? { get set }
    var dataStore: DataStoreProtocol? { get set }
    var toDay: Int? { get set }
    var checkDay: Int? { get set }
    init(mainRouter: MainRouterProtocol?, timerTimerArray: TimerTimeArrayProtocol?, dataStore: DataStoreProtocol?, timerStatistics: TimerStatistics?)
}

final class MainViewModell: MainViewModellProtocol {
    private let mainRouter: MainRouterProtocol?
    private var timerTimerArray: TimerTimeArrayProtocol?
    var dataStore: DataStoreProtocol?
    private let timerStatistics: TimerStatistics?
    var model: Results<TimerModelData>?
    var index: Int?
    var timerCounting: Bool? = false
    var collectionView: UICollectionView?
    var weekDayCollectionView: UICollectionView?
    var timerTimeUpdate: Int?
    var timerStatisticSaveTime: Int? = 0
    private let cal = Calendar.current
    private let date = Date()
    var predicateRepeat: NSPredicate?
    var weekDayArray: [String]? = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var tapWeekDayArray: [Int : Bool]? = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false]
    var toDay: Int?
    var checkDay: Int?
    var endOFTheDayTimer: Timer?
    init(mainRouter: MainRouterProtocol?, timerTimerArray: TimerTimeArrayProtocol?, dataStore: DataStoreProtocol?, timerStatistics: TimerStatistics?) {
        self.mainRouter = mainRouter
        self.timerTimerArray = timerTimerArray
        self.dataStore = dataStore
        self.timerStatistics = timerStatistics
        weekDay()
        model = dataStore?.timerArray
        ifTimerOnNextday()
        endOFTheDayViewUpdate()
    }
    
    func tapTHeAddNewTimerVc() {
        mainRouter?.showAddNewTimerVc()
    }
    
    func tapOnTheTimerDetailVc(index: Int) {
        mainRouter?.showTimerDetail(index: index, predicate: predicateRepeat!)
    }
    
    func remiveTest() {
        dataStore?.deleteObjectAll()
    }
    
    func setIndex(index: Int?) {
        guard let index = index else { return }
        try! realm.write {
            dataStore?.timerArray?[index].index = index
        }
    }
    
    func sentPredicate(predicate: NSPredicate) {
        predicateRepeat = predicate
        dataStore?.predicateFilter(predicate: predicate)
        model = dataStore?.timerArray

    }
    
    //MARK: - weekDay
    func weekDay() {
        let datee = cal.date(byAdding: .day, value: -1, to: Date())!
        let weekday = Calendar.current.component(.weekday, from: datee)
        toDay = weekday
        checkDay = weekday
        tapWeekDayArray?[weekday] = true
        let day = weekDayArray?[weekday - 1]
        predicateRepeat = NSPredicate(format: "\(day!) = true")
        dataStore?.predicateFilter(predicate: predicateRepeat)
//        self.dataStore?.timerArray = realm.objects(TimerModelData.self)
    }
    
    //MARK: - Timer Remove
    func timerRemove(modelIndex: TimerModelData, removeBool: Bool, index: Int, view: UIViewController, collectionView: UICollectionView) {
        let alert = UIAlertController(title: "100% ?", message: nil, preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { action in
            if let cell = self.collectionView?.cellForItem(at: [0, index]) as? MainCollectionViewCelll {
                cell.timerIsRemove()
            }
            try! realm.write {
                self.dataStore?.timerArray?[index].startTimer = nil
                self.dataStore?.timerArray?[index].stopTimer = nil
            }
            if removeBool == true {
                self.dataStore?.deleteObject(modelIndex)
                self.timerCounting = true
                self.index = nil
            }else {
                self.dataStore?.deleteObject(modelIndex)
                self.index = nil
            }
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        let actionBack = UIAlertAction(title: "Back", style: .cancel, handler: nil)
        alert.addAction(actionDelete)
        alert.addAction(actionBack)
        view.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Timer Time Update
    func timerTimeUpdate(timerTimeUpdate: Int, index: Int?) {
        guard let index = index else { return }
        let donee = dataStore?.timerArray?[index].timerDone
        try! realm.write {
            dataStore?.timerArray?[index].timerUpdateTime = timerTimeUpdate
        }
        if timerTimeUpdate <= 0{
            timerReset(index: index)
            try! realm.write {
                if dataStore?.timerArray?[index].todayDate == date.getFormattedDate() {
                    dataStore?.timerArray?[index].timerDone = true
                    dataStore?.timerArray?[index].theTimerIsFinishedHowManyTimes += 1
                    dataStore?.timerArray?[index].timerDoneDate = Date().getFormattedDate()
                }
            }
        }
        //timer statistics add
        let timerTimeeee = (dataStore?.timerArray?[index].timerTime)! - timerTimeUpdate
        dataStore?.saveTimerStatistics(key: Date().getFormattedDate(), value: timerTimeeee, index: index)

        
        
//        print("--------111 === \(dataStore?.timerArray?[index].todayDate)")
//        print("---------222 === \(date.getFormattedDate() )")

//        let datee = cal.date(byAdding: .day, value: 3, to: Date())!

        //Timer ishdiye ishdiye eger saat 00:00 olursa onda bu funcciya ishe dushur
        if dataStore?.timerArray?[index].todayDate != date.getFormattedDate() {
            ifTimerOnNextday()
//            print("111 === \(dataStore?.timerArray?[index].todayDate)")
            dataStore?.timerArray = realm.objects(TimerModelData.self).filter(predicateRepeat!)
//            print("222 === \(dataStore?.timerArray?[index].todayDate)")
            var modelIndex = dataStore?.timerArray?.count
            if modelIndex != 0 {
                modelIndex! -= 1
                print("COUNTT MODEl ===-=-=-=-=-=-=- \(modelIndex)")
                for i in 0...modelIndex! {
                    timerDayOff(index: i)
                }
            }
        }
        
        
        //============================
        if dataStore?.timerArray?[index].timer24houresResetOnOff == true {
//            timer24hourse(index: index)
        }else {

        }
//        if date.getFormattedDateTime() == date.endOfDay.getFormattedDateTime() {
//            print("END OFF DAY -=-=-=-=-=-++++_+_+_+_+_+_+_ timee1 == \(date.getFormattedDateTime()), endOfDay == \(date.endOfDay.getFormattedDateTime())")
//        }
        if dataStore?.timerArray?[index].todayDate == Date().getFormattedDate() {
            
        }
    }
    
    //MARK: - Timer Start Stop
    func timerStartStop(timerCounting: Bool, index: Int?, startTime: Date?, stopTime: Date?) {
        guard let index = index else { return }
        if timerCounting == true && self.index == nil && dataStore?.timerArray?[index].timerDone == false {
            self.timerCounting = timerCounting
            self.index = index
            
            
            try! realm.write {
                dataStore?.timerArray?[index].bugFixBool = timerCounting
                dataStore?.timerArray?[index].timerCounting = timerCounting
                dataStore?.timerArray?[index].startTimer = startTime
                //                dataStore?.timerArray?[index].todayDate = date.getFormattedDate()
            }
            if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
                cell.startTimer()
            }
            print("STARTT")
            //            timer24hourse()
        }else if timerCounting == false && self.index == index {
            self.timerCounting = timerCounting
            self.index = nil
            //            guard let index = index else { return }
            try! realm.write {
                dataStore?.timerArray?[index].bugFixBool = timerCounting
                dataStore?.timerArray?[index].timerCounting = timerCounting
                dataStore?.timerArray?[index].stopTimer = stopTime
            }
            if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
                cell.stopTimer()
            }
            
            endOFTheDayViewUpdate()
            
        }else if dataStore?.timerArray?[index].timerDone == true {
            if let cell = self.collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
                cell.missTimer()
            }
            print("timer done trueee")
        }else {
            //            guard let index = index else { return }
            if let cell = self.collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
                cell.missTimer()
            }
            print("REIS ALINMADI ancaq birin sec")
        }
    }
    
    //MARK: - TimerReset or Timer == 0
    private func timerReset(index: Int) {
        self.index = nil
        try! realm.write {
            dataStore?.timerArray?[index].startTimer = nil
            dataStore?.timerArray?[index].stopTimer = nil
            dataStore?.timerArray?[index].timerCounting = false
            dataStore?.timerArray?[index].timerDone = false
            dataStore?.timerArray?[index].timerUpdateTime = (dataStore?.timerArray?[index].timerTime)!
        }
        
        if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
            cell.stopTimer()
        }
        
    }
    
    //MARK: - Timer 24 Hourse On
    private func timer24hourseOn() {
        var modelIndex = dataStore?.timerArray?.count
        if modelIndex != 0 {
            modelIndex! -= 1
            for i in 0...modelIndex! {
              timerDayOff(index: i)
            }
        }
        dataStore?.timerArray = realm.objects(TimerModelData.self).filter(predicateRepeat!)
    }
    
    //MARK: - IfTimerOnNextday
    //Gun sona catandan sora timere girende eger isdeyen timer qalibsa onun bugunku vaxdi sifirlanir, dunenki saat 00:00 qeder isleyen vaxt dunenin statistikasina elave olnur
    func ifTimerOnNextday() {
        dataStore?.timerArray = realm.objects(TimerModelData.self)
//        let datee = cal.date(byAdding: .day, value: 2, to: Date())!
        var modelIndex = dataStore?.timerArray?.count
        if modelIndex != 0 {
            modelIndex! -= 1
            for i in 0...modelIndex! {
                let addTimeStatistic: Int?
                if  dataStore?.timerArray?[i].timerCounting == true && dataStore?.timerArray?[i].todayDate != date.getFormattedDate() {
                    guard let startTime = dataStore?.timerArray?[i].startTimer else { return }
                    let time = calcRestartTime(start: startTime, stop: date.yesterdayEndOfDay)
                    let diff = date.timeIntervalSince(time)
                    if (dataStore?.timerArray?[i].timerTime)! < Int(diff) {
                        addTimeStatistic = dataStore?.timerArray?[i].timerTime
                    }else {
                        addTimeStatistic = Int(diff)
                    }
                    try! realm.write {
                        dataStore?.timerArray?[i].timerDone = false
                        dataStore?.timerArray?[i].timerStatistics[date.yesterdayEndOfDayNeedFormat.getFormattedDate()]! += addTimeStatistic!
                        dataStore?.timerArray?[i].timerStatistics[date.getFormattedDate()] = 0
                    }
                }
            }
            timer24hourseOn()
        }
    }
    
    private func timerDayOff(index: Int) {
//        let datee = cal.date(byAdding: .day, value: 1, to: Date())!

        if dataStore?.timerArray?[index].todayDate != date.getFormattedDate() {
            try! realm.write {
                dataStore?.timerArray?[index].todayDate = date.getFormattedDate()
            }
            weekDayCollectionView?.reloadData()
            collectionView?.reloadData()
            timerReset(index: index)
            print("INDEXXX === \(index)")
        }
    }
    
    //MARK: - End OF The Day View update
    //Eger app aciqdisa ve timer qoshulu deyilse onda her 10 saniyeden bir bu kod isdeyir
    private func endOFTheDayViewUpdate() {
        if !timerCounting! {
            let timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
            endOFTheDayTimer = timer
        }
    }
    
    @objc private func refreshValue() {
            timer24hourseOn() //bug olsa burdan olabiler birde updatede var bundan
    }
    
    
    private func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }

    private func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    
    //=================================================
    //MARK: - Pomodoro Timer
    func pomdoroStartStopTime(index: Int?, pomdoroStartTime: Date?, pomdoroStopTime: Date?) {
        try! realm.write {
            guard let index = index else { return }
            dataStore?.timerArray?[index].pomdoroStartTime = pomdoroStartTime
            dataStore?.timerArray?[index].pomdoroStopTime = pomdoroStopTime
        }
        
    }
    
    func pomodoroTimeUpdate(newTime: Int, pomdoroTimerBreakOrWork: Bool, index: Int) {
        try! realm.write {
            dataStore?.timerArray?[index].pomodoroTimerUpdateTime = newTime
            dataStore?.timerArray?[index].pomodorTimerWorkOrBreak = pomdoroTimerBreakOrWork
        }
        //        print("TIMERR = == \(newTime)  === true falseee  -=-=-=- \(pomdoroTimerBreakOrWork)")
    }
    
}
