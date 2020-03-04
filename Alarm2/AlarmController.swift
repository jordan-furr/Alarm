//
//  AlarmController.swift
//  Alarm2
//
//  Created by Jordan Furr on 3/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmSchedulerDelegate: class {
    //func scheduleUserNotifications(for alarm: Alarm)
    //func cancelUserNotifications(for alarm: Alarm)
}


extension AlarmSchedulerDelegate {
    func scheduleUserNotifications(for alarm: Alarm){
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "body"
        content.sound = .default
        
        let cal = Calendar.current
        let date1 = cal.dateComponents([.hour,.minute], from: alarm.date)
        let calender = UNCalendarNotificationTrigger.init(dateMatching: date1, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: calender)
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error)
        }
        
    }
    func cancelUserNotification(for alarm: Alarm){
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [alarm.uuid])
    }
}
class AlarmController: AlarmSchedulerDelegate {
    
    static let shared = AlarmController()
    var alarms: [Alarm] = []
   
    func addAlarm(date: Date, name:String, enabled:Bool){
        let alarm = Alarm(date: date, name: name, enabled: enabled)
        alarms.append(alarm)
        if alarm.enabled {
           scheduleUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, date: Date, name: String, enabled: Bool) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms[index].date = date
            alarms[index].name = name
            alarms[index].enabled = enabled
        }
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm){
        if let index = alarms.firstIndex(of: alarm) {
            cancelUserNotification(for: alarm)
            alarms.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func toggleIsON(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        if (alarm.enabled){
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotification(for: alarm)
        }
    }
    
    private func fileURL() -> URL {
         let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         let fileName = "alarms.json"
         let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
         return documentsDirectoryURL
     }
     
     func saveToPersistentStore() {
             let encoder = JSONEncoder()
             do {
                 let data = try encoder.encode(alarms)
                 try data.write(to: fileURL())
             } catch let error {
                 print(error)
             }
         }
     func loadFromPersistentStore() {
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: fileURL())
                let alarms = try decoder.decode([Alarm].self, from: data)
                self.alarms = alarms
            } catch let error {
                print(error)
            }
        }
    
}
