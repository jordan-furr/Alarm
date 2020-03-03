//
//  SwitchTableViewCell.swift
//  Alarm2
//
//  Created by Jordan Furr on 3/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(for: SwitchTableViewCell)
}
class SwitchTableViewCell: UITableViewCell {

    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Properties
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - IB Outlets & Actions
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(for: self)
    }
    
    func updateViews(){
        if let alarm = alarm {
            timeLabel.text = alarm.fireTime
            nameLabel.text = alarm.name
            alarmSwitch.isOn = alarm.enabled
        }
    }
    
}
