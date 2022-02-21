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
    func tapOnTheEditVc(timerModel: TimerModelData, index: Int)
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
    var editDayIndex: Int! { get set }
    var viewController: UIViewController? { get set }
    func scrollToIndex(index:Int)
    var timerDoneAlert: TimerDoneAlertProtocol? { get }
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, timerStatistics: TimerStatistics?, timerNotifications: TimerNotificationsProtocol?, timerDoneAlert: TimerDoneAlertProtocol?, timerAlert: TimerAlertProtocol?)
}

final class MainViewModell: MainViewModellProtocol {
    private let mainRouter: MainRouterProtocol?
    private let timerNotifications: TimerNotificationsProtocol?
    var timerDoneAlert: TimerDoneAlertProtocol?
    private let timerAlert: TimerAlertProtocol?
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
    var predicateRepeat: NSPredicate?
    var weekDayArray: [String]? = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var tapWeekDayArray: [Int : Bool]? = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false]
    var toDay: Int?
    var checkDay: Int?
    var endOFTheDayTimer: Timer? {
        willSet {
            endOFTheDayTimer?.invalidate()
        }
    }
    var newDay: Bool = false
    var editDayIndex: Int!
    var viewController: UIViewController?
    private var startScrolViewRect = false
    
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, timerStatistics: TimerStatistics?, timerNotifications: TimerNotificationsProtocol?, timerDoneAlert: TimerDoneAlertProtocol?, timerAlert: TimerAlertProtocol?) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.timerNotifications = timerNotifications
        self.timerStatistics = timerStatistics
        self.timerDoneAlert = timerDoneAlert
        self.timerAlert = timerAlert
        ifTimerOnNextday()
        weekDay()
        model = dataStore?.timerArray
        endOFTheDayViewUpdate()
        editDayIndex = toDay
    }
    
    func tapTHeAddNewTimerVc() {
        mainRouter?.showAddNewTimerVc()
    }
    
    func tapOnTheTimerDetailVc(index: Int) {
        mainRouter?.showTimerDetail(index: index, predicate: predicateRepeat!)
    }
    
    func tapOnTheEditVc(timerModel: TimerModelData, index: Int) {
        guard let predicate = predicateRepeat else { return }
        mainRouter?.showEditViewController(timerModel: timerModel, index: index, predicate: predicate, day: editDayIndex, col: collectionView!)
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
        for i in 1...7 {
            tapWeekDayArray?[i] = false
        }
        tapWeekDayArray?[weekday] = true
        let day = weekDayArray?[weekday - 1]
        
        predicateRepeat = NSPredicate(format: "\(day!) = true")
        sentPredicate(predicate: predicateRepeat!)
    }
    
    //MARK: - Timer Remove
    func timerRemove(modelIndex: TimerModelData, removeBool: Bool, index: Int, view: UIViewController, collectionView: UICollectionView) {
        let alert = UIAlertController(title: "100% ?", message: nil, preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { action in
            if let selfIndex = self.index {
                if let cell = collectionView.cellForItem(at: [0,selfIndex]) as? MainCollectionViewCelll {
                    cell.stopTimer()
                }
            }
            if let cell = self.collectionView?.cellForItem(at: [0, index]) as? MainCollectionViewCelll {
                cell.timerIsRemove()
            }
            try! realm.write {
                self.dataStore?.timerArray?[index].startTimer = nil
                self.dataStore?.timerArray?[index].stopTimer = nil
            }
            if removeBool == true {
                self.dataStore?.deleteObject(modelIndex)
                self.timerCounting = true//bu sef ola biler
                self.index = nil
            }else {
                self.dataStore?.deleteObject(modelIndex)
                self.index = nil
            }
            DispatchQueue.main.async {
                self.remove(index)
            }
        }
        let actionBack = UIAlertAction(title: "Back", style: .cancel, handler: nil)
        alert.addAction(actionDelete)
        alert.addAction(actionBack)
        view.present(alert, animated: true, completion: nil)
    }
    
    //reload
    func remove(_ i: Int) {
        let indexPath = IndexPath(row: i, section: 0)
        collectionView!.performBatchUpdates({
            collectionView!.deleteItems(at: [indexPath])
        }) { [self] (finished) in
            collectionView!.reloadItems(at: collectionView!.indexPathsForVisibleItems)
        }
    }
    
    //MARK: - Timer Time Update
    func timerTimeUpdate(timerTimeUpdate: Int, index: Int?) {
        guard let index = index else { return }
        try! realm.write {
            dataStore?.timerArray?[index].timerUpdateTime = timerTimeUpdate
        }
        
        //timer statistics add
        let timerTimeeee = (dataStore?.timerArray?[index].timerTime)! - timerTimeUpdate
        dataStore?.saveTimerStatistics(key: Date().getFormattedDate(), value: timerTimeeee, index: index)
        
        //Timer Time == 0 olsa
        if timerTimeUpdate <= 0{
            timerReset(index: index)
            timerCounting = false
            dataStore?.saveTimerStatistics(key: Date().getFormattedDate(), value: (dataStore?.timerArray?[index].timerTime)!, index: index)
            endOFTheDayViewUpdate()
            try! realm.write {
                if dataStore?.timerArray?[index].todayDate == Date().getFormattedDate() {
                    dataStore?.timerArray?[index].timerDone = true
                    dataStore?.timerArray?[index].theTimerIsFinishedHowManyTimes += 1
                    dataStore?.timerArray?[index].timerDoneDate = Date().getFormattedDate()
                }
            }
            dataStore?.deleteLastIndex()
        }
        
        //Timer ishdiye ishdiye eger saat 00:00 olursa onda bu funcciya ishe dushur
        if dataStore?.timerArray?[index].todayDate != Date().getFormattedDate() {
            ifTimerOnNextday()
            weekDay()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView?.reloadData()
                self.weekDayCollectionView?.reloadData()
            }
        }
    }
    
    //MARK: - Timer Start Stop
    func timerStartStop(timerCounting: Bool, index: Int?, startTime: Date?, stopTime: Date?) {
        guard let index = index else { return }
        if timerCounting == true && self.index == nil && dataStore?.timerArray?[index].timerDone == false {
            startTimerViewModel(timerCounting: timerCounting, index: index, startTime: startTime)
        }else if timerCounting == false && self.index == index {
//            collectionView?.reloadData()
            stopTimerViewModel(timerCounting: timerCounting, index: index, stopTime: stopTime)
            
        }else if dataStore?.timerArray?[index].timerDone == true {
            if let cell = self.collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
                cell.missTimer()
            }
            guard let viewController = viewController, let timerName = dataStore?.timerArray?[index].name else { return }
            timerDoneAlert?.showAlert(title: nil, message: "\(timerName)", viewController: viewController)
            print("timer done trueee")
            
        }else if timerCounting == false && self.index != nil {// bu deyesen lazim deyil sora yoxla
            print("stoppppp edittt viewModel 228")
            //      stopTimerViewModel(timerCounting: timerCounting, index: index, stopTime: stopTime)
            
        }else if timerCounting == true && self.index != nil {
            guard let viewController = viewController else { return }
            
            timerAlert?.secondTimerStart(viewController: viewController, completionHandler: { bool in
                if bool {
                    guard let selfIndex = self.index else { return }
                    DispatchQueue.main.async {
                        self.scrollToIndex(index: selfIndex)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.stopTimerViewModel(timerCounting: false, index: selfIndex, stopTime: Date())
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.scrollToIndex(index: index)
                            self.collectionView?.reloadData()
                            if let stopTime = self.dataStore?.timerArray?[index].stopTimer {
                                let restartTime = self.calcRestartTime(start: (self.dataStore?.timerArray?[index].startTimer)!, stop: stopTime)
                                try! realm.write {
                                    self.dataStore?.timerArray?[index].stopTimer = nil
                                }
                                self.startTimerViewModel(timerCounting: true, index: index, startTime: restartTime)
                            }else {
                                self.startTimerViewModel(timerCounting: true, index: index, startTime: Date())
                            }
                        }
                    }
                }else {
                    if let cell = self.collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
                        cell.missTimer()
                    }
                }
            })
            //            if let cell = self.collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
            //                cell.missTimer()
            //            }
            print("ancaq birin sec viewModel 256")
            print("=========================================")
        }
    }
    
    func scrollToIndex(index:Int) {
        guard let rect = self.collectionView?.layoutAttributesForItem(at:IndexPath(row: index, section: 0))?.frame else { return }
        self.collectionView?.scrollRectToVisible(rect, animated: false)
    }
    
    
    //MARK: - Stop Timer ViewModel
    private func stopTimerViewModel(timerCounting: Bool, index: Int, stopTime: Date?) {
        self.timerCounting = timerCounting
        self.index = nil
        try! realm.write {
            dataStore?.timerArray?[index].bugFixBool = timerCounting
            dataStore?.timerArray?[index].timerCounting = timerCounting
            dataStore?.timerArray?[index].stopTimer = stopTime
        }
        if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
            cell.stopTimer()
        }
        timerNotifications?.removeNotifications(withIdentifires: ["MyUniqueIdentifire"])
        endOFTheDayViewUpdate()
        dataStore?.deleteLastIndex()
        print("VIEWMODEL STOP")
    }
    
    //MARK: - Start Timer ViewModel
    private func startTimerViewModel(timerCounting: Bool, index: Int, startTime: Date?) {
        if endOFTheDayTimer != nil {
            endOFTheDayTimer?.invalidate()
            endOFTheDayTimer = nil
        }
        self.timerCounting = timerCounting
        self.index = index
        
        try! realm.write {
            dataStore?.timerArray?[index].bugFixBool = timerCounting
            dataStore?.timerArray?[index].timerCounting = timerCounting
            dataStore?.timerArray?[index].startTimer = startTime
            dataStore?.timerArray?[index].timerStartToDay = true
            dataStore?.timerArray?[index].todayDate = Date().getFormattedDate()
        }
        if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
            cell.startTimer()
        }
        dataStore?.deleteLastIndex()
        let lastIndex = LastIndex(index: index)
        dataStore?.saveLastIndex(lastIndex)
        timerNotifications?.scheduleNotification(inSeconds: TimeInterval((dataStore?.timerArray?[index].timerUpdateTime)!), timerName: (dataStore?.timerArray?[index].name)!)
        print("VIEWMODEL START")
    }
    
    //MARK: - TimerReset or Timer == 0
    private func timerReset(index: Int) {
        self.index = nil
        try! realm.write {
            dataStore?.timerArray?[index].startTimer = nil
            dataStore?.timerArray?[index].stopTimer = nil
            dataStore?.timerArray?[index].timerCounting = false
            dataStore?.timerArray?[index].timerDone = false
            dataStore?.timerArray?[index].timerStartToDay = false
            dataStore?.timerArray?[index].timerUpdateTime = (dataStore?.timerArray?[index].timerTime)!
        }
        
        if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCelll {
            cell.stopTimer()
        }
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
                if  dataStore?.timerArray?[i].timerCounting == true && dataStore?.timerArray?[i].todayDate != Date().getFormattedDate() {
                    guard let startTime = dataStore?.timerArray?[i].startTimer else { return }
                    let time = calcRestartTime(start: startTime, stop: Date().yesterdayEndOfDay)
                    let diff = Date().timeIntervalSince(time)//startdan gunun sonuna olan vaxt
                    if (dataStore?.timerArray?[i].timerTime)! < Int(diff) {
                        addTimeStatistic = dataStore?.timerArray?[i].timerTime
                    }else {
                        addTimeStatistic = Int(diff)
                    }
                    try! realm.write {
                        dataStore?.timerArray?[i].timerDone = false
                        dataStore?.timerArray?[i].timerStatistics[Date().yesterdayEndOfDayNeedFormat.getFormattedDate()]! += addTimeStatistic!
                        dataStore?.timerArray?[i].timerStatistics[Date().getFormattedDate()] = 0
                    }
                }
            }
            timer24hourseOn()
        }
    }
    
    //MARK: - Timer 24 Hourse On
    private func timer24hourseOn() { //+
        var modelIndex = dataStore?.timerArray?.count
        if modelIndex != 0 {
            modelIndex! -= 1
            for i in 0...modelIndex! {
                timerDayOff(index: i)
            }
        }
        //                dataStore?.timerArray = realm.objects(TimerModelData.self).filter(predicateRepeat!)
    }
    
    private func timerDayOff(index: Int) {
        if dataStore?.timerArray?[index].todayDate != Date().getFormattedDate() {
            try! realm.write {
                dataStore?.timerArray?[index].todayDate = Date().getFormattedDate()
                dataStore?.timerArray?[index].timerStartToDay = false
                if dataStore?.timerArray?[index].editTimerTimeBool == true { //edit vc de yeni timerTime olsa
                    guard let newTime =  dataStore?.timerArray?[index].editTimerTime else { return }
                    dataStore?.timerArray?[index].timerTime = newTime
                    dataStore?.timerArray?[index].editTimerTimeBool = false
                }
            }
            newDay = true
            timerReset(index: index)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView?.reloadData()
                self.weekDayCollectionView?.reloadData()
            }
            //            timerReset(index: index)
        }
    }
    
    //MARK: - End OF The Day View update
    //Eger app aciqdisa ve timer qoshulu deyilse onda her 5 saniyeden bir bu kod isdeyir
    private func endOFTheDayViewUpdate() {
        if self.index == nil {
            let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
            endOFTheDayTimer = timer
        }
    }
    
    @objc private func refreshValue() {
        //        print("5 sec reload")
        var modelIndex = dataStore?.timerArray?.count
        if modelIndex != 0 {
            modelIndex! -= 1
            for i in 0...modelIndex! {
                timerDayOff(index: i)
            }
        }
        if newDay {
            weekDay()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView?.reloadData()
                self.weekDayCollectionView?.reloadData()
            }
            newDay = false
        }
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
        //        try! realm.write {
        //            dataStore?.timerArray?[index].pomodoroTimerUpdateTime = newTime
        //            dataStore?.timerArray?[index].pomodorTimerWorkOrBreak = pomdoroTimerBreakOrWork
        //        }
        //        print("TIMERR = == \(newTime)  === true falseee  -=-=-=- \(pomdoroTimerBreakOrWork)")
    }
    
}
