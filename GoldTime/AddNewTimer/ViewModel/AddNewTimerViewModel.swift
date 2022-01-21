//
//  AddNewTimerViewModel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

protocol AddNewTimerViewModelProtocol {
    func saveTimer(timer: TimerModelData)
    func popVC()
    var color: UIColor? { get set }
    init(mainRouter: MainRouterProtocol?, timerTimerArray: TimerTimeArrayProtocol?, dataStore: DataStoreProtocol?)
}

final class AddNewTimerViewModel: AddNewTimerViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    private var timerTimerArray: TimerTimeArrayProtocol?
    private let dataStore: DataStoreProtocol?
    var color: UIColor?
    init(mainRouter: MainRouterProtocol?, timerTimerArray: TimerTimeArrayProtocol?, dataStore: DataStoreProtocol?) {
        self.mainRouter = mainRouter
        self.timerTimerArray = timerTimerArray
        self.dataStore = dataStore
    }
    
    func saveTimer(timer: TimerModelData) {
        dataStore?.saveObject(timer)
    }
    
    func popVC() {
        mainRouter?.popVC()
    }
}
