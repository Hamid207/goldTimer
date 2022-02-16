//
//  TimerDoneAlert.swift
//  GoldTime
//
//  Created by Hamid Manafov on 16.02.22.
//

import UIKit

protocol TimerDoneAlertProtocol {
  func showAlert(title: String?, message: String, viewController: UIViewController)
}

final class TimerDoneAlert: TimerDoneAlertProtocol {
  
  private lazy var alertViewIsSelected = false
  
  private let alertView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 10
    view.setupShadow(opacity: 0.4, radius: 10, offset: .init(width: 0, height: 0), color: .black)
    return view
  }()
  
  internal func showAlert(title: String?, message: String, viewController: UIViewController) {
    if alertViewIsSelected == false {
      guard let targetView = viewController.view else { return }
      
      alertView.frame = CGRect(x: 25, y: -100, width: targetView.frame.width - 50, height: 80)
      targetView.addSubview(alertView)
      
      let messsageLabel = UILabel(frame: CGRect(x: 10, y: 10, width: alertView.frame.width - 20, height: 30))
      messsageLabel.text = "\(message) Done"
      messsageLabel.textAlignment = .left
      messsageLabel.textColor = .black
      messsageLabel.numberOfLines = 0
      alertView.addSubview(messsageLabel)
      
      UIView.animate(withDuration: 0.3, animations: {
        self.alertViewIsSelected = true
      }, completion: { done in
        if done {
          UIView.animate(withDuration: 0.3, animations: {
            self.alertView.frame = CGRect(x: 25, y: 100, width: targetView.frame.width - 50, height: 80)
          })
        }
      })
      
      
      if alertViewIsSelected == true {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          
          UIView.animate(withDuration: 0.3, animations: {
            self.alertView.frame = CGRect(x: 25, y: -targetView.frame.height, width: targetView.frame.width - 50, height: 80)
            
          }, completion: { done in
            if done {
              self.alertView.removeFromSuperview()
              messsageLabel.removeFromSuperview()
              self.alertViewIsSelected = false
            
            }
          })
        }
      }
    }
  }
  
  
  
}
