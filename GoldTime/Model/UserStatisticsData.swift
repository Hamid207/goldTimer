//
//  UserStatisticsData.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import RealmSwift

final class UserStatisticsData: Object {
    @Persisted var timerstatistic: String?
    
    convenience init(timerstatistic: String?) {
        self.init()
        self.timerstatistic = timerstatistic
    }
}
