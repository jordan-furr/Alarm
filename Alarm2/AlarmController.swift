//
//  AlarmController.swift
//  Alarm2
//
//  Created by Jordan Furr on 3/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    var alarms: [Alarm] = [
        Alarm(date: Date(timeIntervalSinceNow: 0.60), name: "Dinner", enabled: false)]
   
    func addAlarm(date: Date, name:String, enabled:Bool){
        let alarm = Alarm(date: date, name: name, enabled: enabled)
        alarms.append(alarm)
    }
    
    func update(alarm: Alarm, date: Date, name: String, enabled: Bool) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms[index].date = date
            alarms[index].name = name
            alarms[index].enabled = enabled
        }
    }
    
    func delete(alarm: Alarm){
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
        }
    }
    
    static func toggleIsON(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
}
