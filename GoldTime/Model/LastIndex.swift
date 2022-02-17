//
//  LastIndex.swift
//  GoldTime
//
//  Created by Hamid Manafov on 17.02.22.
//

import RealmSwift

class LastIndex: Object {
  @Persisted var index: Int
  
  convenience init(index: Int) {
    self.init()
    self.index = index
  }
}
