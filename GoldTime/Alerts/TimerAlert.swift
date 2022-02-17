//
//  TimerAlert.swift
//  GoldTime
//
//  Created by Hamid Manafov on 16.02.22.
//

import UIKit

protocol TimerAlertProtocol {
  func secondTimerStart(viewController: UIViewController, completionHandler: @escaping (Bool) -> Void)
}

final class TimerAlert: TimerAlertProtocol {
  
  func secondTimerStart(viewController: UIViewController, completionHandler: @escaping (Bool) -> Void) {
    let alert = UIAlertController(title: nil, message: "Sizde artiq timer isdeyir ", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { action in
      completionHandler(true)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { cancel in
      completionHandler(false)
    }
    alert.addAction(action)
    alert.addAction(cancel)
    viewController.present(alert, animated: true, completion: nil)
  }
}
