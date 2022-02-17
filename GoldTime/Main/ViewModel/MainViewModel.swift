//
//  MainViewModel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import RealmSwift

protocol MainViewModelProtocol {
    func timerModel()
    func tapTHeAddNewTimerVc()
    func tapOnTheTimerDetailVc(index: Int)
    var model: Results<TimerModelData>? { get set }
    func timerStart(index: Int?, secondTimerDontStart: Bool?, bugFixBool: Bool?)
    func remiveTest()
    func timerRemove(modelIndex: TimerModelData, deleteBool: Bool, cellIndex: Int, view: UIViewController, collectionView: UICollectionView)
    var startFix: Bool? { get set }
    var bugFixBool: Bool? { get set }
    var collectionView: UICollectionView? { get set }
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?)
}

final class MainViewModel: MainViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    private let dataStore: DataStoreProtocol?
    private weak var timer: Timer?
    private lazy var secondTimerDontStart: Bool? = false
    private var index: Int?
    private var minusTime: Int?
    var model: Results<TimerModelData>?
    lazy var startFix: Bool? = false
    var bugFixBool: Bool?
    var collectionView: UICollectionView?
    private var isTimerEnd: Bool = false
    private var startTime: Date?
    private var stopTime: Date?
    private var timerTime: Int!
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        model = dataStore?.timerArray
    }
    
    func tapTHeAddNewTimerVc() {
        mainRouter?.showAddNewTimerVc()
    }
    
    func tapOnTheTimerDetailVc(index: Int) {
//        mainRouter?.showTimerDetail(index: index, predicate: <#NSPredicate#>)
    }
    
    func remiveTest() {
        dataStore?.deleteObjectAll()
    }
    
    func timerModel() {
        //        self.index = dataStore?.index
    }
    
    //MARK: - Timer delete
    func timerRemove(modelIndex: TimerModelData, deleteBool: Bool, cellIndex: Int, view: UIViewController, collectionView: UICollectionView) {
        let alert = UIAlertController(title: "100% ?", message: nil, preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { action in
            if deleteBool == true {
                if let cell = self.collectionView?.cellForItem(at: [0, cellIndex]) as? MainCollectionViewCell {
                    cell.pauseTimer()
                }
                self.mainTimerPause()
                self.dataStore?.deleteObject(modelIndex)
                self.secondTimerDontStart = false
            }else {
                self.dataStore?.deleteObject(modelIndex)
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
    
    //MARK: - Timer start or pause
    func timerStart(index: Int?, secondTimerDontStart: Bool?, bugFixBool: Bool?) {//timer pause
        guard let index = index else { return }
        if self.secondTimerDontStart == true && self.index == index{
            self.secondTimerDontStart = secondTimerDontStart
            stopTime = Date()
            try! realm.write {
                dataStore?.timerArray?[index].bugFixBool = bugFixBool
                dataStore?.timerArray?[index].stopTimer = stopTime
            }
            
            if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCell {
                cell.pauseTimer()
            }
            print("VIEWMO PAUSE")
            mainTimerPause()
        }else if self.secondTimerDontStart == false && self.index == nil{//timer start
            self.secondTimerDontStart = secondTimerDontStart
            self.index = index
            
            
            if let stop = stopTime
            {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
//                setStopTime(date: nil)
                stopTime = nil
//                setStartTime(date: restartTime)
                startTime = restartTime
                print("Stop time = \(stop)")
                print("restartTime = \(restartTime)")
            }
            else
            {
                //1
                startTime = Date()
                print("=-=-=-=-=-=-=-=-=-=-=-=-==-==-=-=-=-=")
            }
//            startTime = Date()
            
            
            try! realm.write {
                dataStore?.timerArray?[index].bugFixBool = bugFixBool
                dataStore?.timerArray?[index].startTimer = startTime
            }
            timerTime = (dataStore?.timerArray?[index].timerTime)!
            if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCell {
                cell.startTimer()
            }
            
            mainTimerStart()
        }else {
            print("ALERTT NEED TIMER STOP!")
        }
    }
    
    private func mainTimerStart() {
        guard let index = self.index else { return }
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startStop), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        self.timer = timer
        try! realm.write {
            dataStore?.timerArray?[index].startFix = true
            model?[index].startFix = true
//            dataStore?.timerArray?[0].test.first?.name
        }
    }
    
    private func mainTimerPause() {
        guard let index = self.index else { return }
        timer?.invalidate()
        timer = nil
        try! realm.write {
            dataStore?.timerArray?[index].startFix = false
            model?[index].startFix = false
        }
        self.index = nil
    }
    
    //MARK: - Start Stop
    @objc private func startStop() {
        guard let index = self.index else { return }
        
        if let cell = collectionView?.cellForItem(at: [0,index]) as? MainCollectionViewCell {
            cell.timerStart()
        }
        
        let diff = startTime?.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-timerTime)))
        self.setTimeLabel(Int(diff!))
        print("DIFF = === == \(Int(diff!))")
        try! realm.write {
            dataStore?.timerArray?[index].timerTime = Int(diff!)

//            dataStore?.timerArray?[index].seconds -= 1
//            if dataStore?.timerArray?[index].seconds == -1 {
//                dataStore?.timerArray?[index].minute -= 1
//                dataStore?.timerArray?[index].seconds = 59
//            }
//
//            if dataStore?.timerArray?[index].minute == -1 {
//                dataStore?.timerArray?[index].hourse -= 1
//                dataStore?.timerArray?[index].minute = 59
//            }
//
//            let h = dataStore?.timerArray?[index].hourse
//            let m = dataStore?.timerArray?[index].minute
//            let s = dataStore?.timerArray?[index].seconds
//            minusTime = Int(h!) * 3600 + Int(m!) * 60 + Int(s!)
//            dataStore?.timerArray?[index].userTimerstatistics! += 1
//
            if Int(diff!) == 0 {
                timer?.invalidate()
                timer = nil
                
                //Timer sona catanda bugfixBool false olur yoxsa proqrama tezden girende aftomatic timer basdayacaq isdemeye
                dataStore?.timerArray?[index].bugFixBool = false

                isTimerEnd = true

                self.secondTimerDontStart = false
                self.index = nil
            }
            
            if dataStore?.timerArray?[index].hourse == 0 && dataStore?.timerArray?[index].minute == 0 && dataStore?.timerArray?[index].seconds == 0 {
                timer?.invalidate()
                timer = nil

                //Timer bitende vaxt evvele qayidir
                let time = TimeInterval(dataStore?.timerArray?[index].statick ?? 0)
                let hour = Int(time) / 3600
                let minute = Int(time) / 60 % 60
                let second = Int(time) % 60
                dataStore?.timerArray?[index].hourse = hour
                dataStore?.timerArray?[index].minute = minute
                dataStore?.timerArray?[index].seconds = second

                //Timer sona catanda bugfixBool false olur yoxsa proqrama tezden girende aftomatic timer basdayacaq isdemeye
                dataStore?.timerArray?[index].bugFixBool = false

                isTimerEnd = true

                self.secondTimerDontStart = false
                self.index = nil
            }
            
            //pomodor timer
            if dataStore?.timerArray?[index].pomodoroTimerOnOff == true {
                if !isTimerEnd {
                    pomodoroTimer()
                }else {
                    isTimerEnd = false
                    dataStore?.timerArray?[index].pomodoroTime! = 10
                    dataStore?.timerArray?[index].pomodorTimerWorkOrBreak = true
                }
            }
        }
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date
    {
        let diff = start.timeIntervalSince(stop)
        print("calcRestartTime = \(diff) , start = \(start), stop = \(stop)")
        print("calcRestartTime Date().addingTimeInterval(diff) = \(Date().addingTimeInterval(diff))")

        return Date().addingTimeInterval(diff)
    }
    
    
    func setTimeLabel(_ val: Int)
    {
//        let time = secondsToHoursMinutesSeconds(val)
//        print("time = \(time)")
//        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
//        print("viewMODWll -=-=- -=-=-=-timeString = \(timeString)")
    }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int)
    {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    //MARK: - Pomodoro Timer
    private func pomodoroTimer() {
        guard let index = self.index else { return }
        
        //dataStore?.timerArray?[index].pomodorTimerWorkOrBreak == true olanda demeli pomodoroTimer 5 deyqedi false olanda 25 deyqe
        if dataStore?.timerArray?[index].pomodoroTimerOnOff == true {
            dataStore?.timerArray?[index].pomodoroTime! -= 1
            if dataStore?.timerArray?[index].pomodoroTime == 0 && dataStore?.timerArray?[index].pomodorTimerWorkOrBreak == true {
                dataStore?.timerArray?[index].pomodoroTime! = 5
                dataStore?.timerArray?[index].pomodorTimerWorkOrBreak = false
            }else if dataStore?.timerArray?[index].pomodoroTime == 0 && dataStore?.timerArray?[index].pomodorTimerWorkOrBreak == false {
                dataStore?.timerArray?[index].pomodoroTime! = 10
                dataStore?.timerArray?[index].pomodorTimerWorkOrBreak = true
            }
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        // return formated string
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
    
}
