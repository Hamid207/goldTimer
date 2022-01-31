//
//  SentColorDelegate.swift
//  GoldTime
//
//  Created by Hamid Manafov on 28.01.22.
//

import UIKit

protocol SentColorDelegate: AnyObject {
    func setColorDelegate(color: String?, colorIndex: Int)
}

protocol EditColorDelegate: AnyObject {
    func sentNewColor(color: String?, colorIndex: Int)
}
