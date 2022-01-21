//
//  SentTimerStatisticDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation

protocol SentTimerStatisticDelegate: AnyObject {
    func sentTimerStatisticDelegate(days: TimerStatisticsEnum)
}
