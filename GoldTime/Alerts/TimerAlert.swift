//
//  TimerAlert.swift
//  GoldTime
//
//  Created by Hamid Manafov on 16.02.22.
//

import UIKit

enum AlertEnum: String {
    case OK
    case Delete
}

protocol TimerAlertProtocol {
    func alert(viewController: UIViewController, alertEnum: AlertEnum, alertTitle: String?, alertMessage: String?, preferredStyle: UIAlertAction.Style, completionHandler: @escaping (Bool) -> Void)
}

final class TimerAlert: TimerAlertProtocol {
    
    func alert(viewController: UIViewController, alertEnum: AlertEnum, alertTitle: String?, alertMessage: String?, preferredStyle: UIAlertAction.Style, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: alertEnum.rawValue, style: preferredStyle) { action in
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
