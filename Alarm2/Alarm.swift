//
//  Alarm.swift
//  Alarm2
//
//  Created by Jordan Furr on 3/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable {
    var date: Date
    var name: String
    var enabled: Bool
    let uuid: String = UUID().uuidString
    
    var fireTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    init(date: Date, name: String, enabled: Bool) {
        self.date = date
        self.name = name
        self.enabled = enabled
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool{
    return lhs.date == rhs.date && lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid
}
