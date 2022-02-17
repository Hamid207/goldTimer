//
//  TimerNotifications.swift
//  GoldTime
//
//  Created by Hamid Manafov on 01.02.22.
//

import Foundation
import UserNotifications

protocol TimerNotificationsProtocol {
    func scheduleNotification(inSeconds seconds: TimeInterval, timerName name: String)
    func removeNotifications(withIdentifires identifires: [String])
}

class TimerNotifications: TimerNotificationsProtocol {
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func scheduleNotification(inSeconds seconds: TimeInterval, timerName name: String) {
        if Date().getFormattedDate() == Date(timeIntervalSinceNow: seconds).getFormattedDate() {
            removeNotifications(withIdentifires: ["MyUniqueIdentifire"])
            
            notificationCenter.getNotificationSettings { settings in
                let title = "\(name) finished"
                let date = Date(timeIntervalSinceNow: seconds)
                if settings.authorizationStatus == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.sound = UNNotificationSound.default
                    
                    let dateComp = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let regguest = UNNotificationRequest(identifier: "MyUniqueIdentifire", content: content, trigger: trigger)
                    self.notificationCenter.add(regguest) { (error) in
                        if (error != nil) {
                            print("notificationCenter Error == 33 line" + error.debugDescription)
                            return
                        }
                    }
                }else {
                    print("NOTIFICATIONOFFF")
                }
            }
        }
       
    }
    
    
    func removeNotifications(withIdentifires identifires: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifires)
    }
    
//    deinit {
//        print("DEINIT")
//        removeNotifications(withIdentifires: ["MyUniqueIdentifire"])
//    }

}
