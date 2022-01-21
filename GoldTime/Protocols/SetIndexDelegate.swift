//
//  SetIndexDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation

protocol SetIndexDelegate: AnyObject {
    func setIndex(index: Int?)
}

protocol AddModelIndexDelegate: AnyObject {
    func addModelIndex(index: Int)
}
