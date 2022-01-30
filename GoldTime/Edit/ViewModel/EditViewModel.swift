//
//  EditViewModel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 30.01.22.
//

import Foundation
protocol EditViewModelProtocol{
    func popVC()
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?)
}

final class EditViewModel: EditViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    private let dataStore: DataStoreProtocol?
    init(mainRouter: MainRouterProtocol?,dataStore: DataStoreProtocol?) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
    }
    
    func popVC() {
        mainRouter?.popVC()
    }
}
