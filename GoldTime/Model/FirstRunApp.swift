//
//  FirstRunApp.swift
//  GoldTime
//
//  Created by Hamid Manafov on 29.03.22.
//

import RealmSwift

final class FirstRunApp: Object {
    @Persisted var firstRunApp: Bool = false
}
