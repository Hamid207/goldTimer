//
//  LastUseTimerIndex.swift
//  GoldTime
//
//  Created by Hamid Manafov on 23.01.22.
//

import RealmSwift

final class LastUseTimerIndex: Object {
    @Persisted var lastUseTimerIndex: Int?
}
