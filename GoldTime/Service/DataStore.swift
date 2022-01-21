//
//  DataStore.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import RealmSwift

let realm = try! Realm()

protocol DataStoreProtocol {
    var timerArray: Results<TimerModelData>? { get set }
    var userStaticsArray: Results<UserStatisticsData>? { get set }
    func startStop()
    var startPauseBool: Bool? { get set }
    func timerStart(index: Int, startPauseBool: Bool?, completion: @escaping (Bool) -> Void)
    func saveObject(_ timerModel: TimerModelData)
    func deleteObject(_ timerModel: TimerModelData)
    func userStaticSaveObject(_ userStaticModel: UserStatisticsData)
    func deleteObjectAll()
    var index: Int? { get set }
    var indexUserDefolts: UserDefaults? { get set }
    var timerBoolUserDefolts: UserDefaults? { get set }
    var timerBool: Bool? { get set }
    func predicateFilter(predicate: NSPredicate?)
}

class DataStore: DataStoreProtocol {
    var timerArray: Results<TimerModelData>?
    var userStaticsArray: Results<UserStatisticsData>?
    private var timer = Timer()
    var startPauseBool: Bool?
    var index: Int?
    var timerBoolUserDefolts: UserDefaults?
    var timerBool: Bool?
    var timerNonStart: Bool? = false
    var indexUserDefolts: UserDefaults?
    private var predecate: NSPredicate!
    init() {
        timerArray = realm.objects(TimerModelData.self)
        userStaticsArray = realm.objects(UserStatisticsData.self)
        indexUserDefolts = UserDefaults.standard
        timerBoolUserDefolts = UserDefaults.standard
        index = indexUserDefolts?.object(forKey: "index") as? Int ?? 0
        timerBool = timerBoolUserDefolts?.object(forKey: "startBool") as? Bool ?? false
    }
    
    func predicateFilter(predicate: NSPredicate?) {
        predecate = predicate
        if predicate != nil {
            timerArray = realm.objects(TimerModelData.self).filter(predicate!)
//            print("AAA == \(timerArray)")
        }else {
//            timerArray = realm.objects(TimerModelData.self)
        }
//        timerArray = realm.objects(TimerModelData.self).filter(predicate)
    }
    
    
    func timerStart(index: Int, startPauseBool: Bool?, completion: @escaping (Bool) -> Void) {
        self.index = index
        timerBoolUserDefolts?.set(self.timerBool, forKey: "startBool")
        indexUserDefolts?.set(self.index, forKey: "index")
//        for i in timerArray! {
//            if i.startFix == true{
//                completion(true)
//            }else {
//               completion(false)
//            }
//        }
//        print("DATASTORE VC startPauseBool -=-= \(startPauseBool )")
//        DispatchQueue.main.async { [weak self] in
////            print("DaTA STORE THREAD === \(Thread.printCurrent())")
//            guard let self = self else { return }
//            self.index = index
//            if startPauseBool! == false {
//                print("ISDEMIRRR??")
////                print("FALSEEEE ---DATASTOREEE")
//                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startStop), userInfo: nil, repeats: true)
//                self.timerNonStart = true
//                print("START1 = \(self.timerArray)")
//                try! realm.write {
//                    self.timerArray?[index].startFix = true
//    //                startFix = true
//                }
//                print("START2 = \(self.timerArray)")
//            }else if startPauseBool! == true {
////                print("PAUSE=== \(Thread.printCurrent())")
//                print("ISDEYIRRR??")
//                self.timer.invalidate()
////                print("TRUEEE +++ DATASTOREEE")
//                self.timerNonStart = false
//                print("PAUSE1 = \(self.timerArray)")
//                try! realm.write {
//                    self.timerArray?[index].startFix = false
////                    print(self.timerArray)
//    //                startFix = true
//                }
//                print("PAUSE2 = \(self.timerArray)")
//            }
//        }
    }
    
    @objc func timerStop() {
//        timer.invalidate()
    }
    
    @objc func startStop() {
//        try! realm.write {
////            print("INDEXXDatastore -=-=- \(index)")
//            timerArray?[index].seconds -= 1
//            if timerArray?[index].seconds == -1 {
//                timerArray?[index].minute -= 1
//                timerArray?[index].seconds = 59
//            }
//
//            if timerArray?[index].minute == -1 {
//                timerArray?[index].hourse -= 1
//                timerArray?[index].minute = 59
//            }
//
//            if timerArray?[index].hourse == 0 && timerArray?[index].minute == 0 && timerArray?[index].seconds == 0 {
//                timer.invalidate()
//                timerArray?[index].hourse = timerArray?[index].statickHourese ?? 0
//                timerArray?[index].minute = timerArray?[index].statickMinute ?? 0
//                timerArray?[index].seconds = timerArray?[index].statickSeconds ?? 0
//            }
//        }
    }
    
    //save object DB
    func saveObject(_ timerModel: TimerModelData) {
        try! realm.write {
            realm.add(timerModel)
            
        }
    }
    
    func userStaticSaveObject(_ userStaticModel: UserStatisticsData) {
        try! realm.write{
            realm.add(userStaticModel)
        }
    }
    
    //delete Object DB
    func deleteObject(_ timerModel: TimerModelData) {
        try! realm.write {
            realm.delete(timerModel)
        }
    }
    
    func deleteObjectAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

extension Thread {

    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}

extension Thread {
    class func printCurrent() {
        print("\r⚡️: \(Thread.current)\r" + ": \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
    }
}

