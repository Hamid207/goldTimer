//
//  TimerAlert.swift
//  GoldTime
//
//  Created by Hamid Manafov on 16.02.22.
//

import UIKit

protocol TimerAlertProtocol {
  func secondTimerStart(viewController: UIViewController)
}

final class TimerAlert: TimerAlertProtocol {
  
  func secondTimerStart(viewController: UIViewController) {
    let alert = UIAlertController(title: nil, message: "Sizde artiq timer isdeyir", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { action in
      print("OK")
    }
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
  }
}
