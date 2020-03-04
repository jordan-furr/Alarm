//
//  DetailTableViewController.swift
//  Alarm2
//
//  Created by Jordan Furr on 3/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var alarmIsOn: Bool = true
    var alarm: Alarm? {
        didSet {
            alarmIsOn = alarm?.enabled ?? true
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        updateAlarm()
    }
    
    //MARK: - IB Outlets & Actions
    @IBOutlet weak var datePicked: UIDatePicker!
    @IBOutlet weak var alarmName: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn = !alarmIsOn
        updateAlarm()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let alarmTitle = alarmName.text {
            if let dateTitle = datePicked?.date {
                if let alarm = alarm {
                    AlarmController.shared.update(alarm: alarm, date: dateTitle, name: alarmTitle, enabled: alarmIsOn)
                } else {
                    AlarmController.shared.addAlarm(date: dateTitle, name: alarmTitle, enabled: alarmIsOn)
                }
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func updateViews(){
        guard let alarm = self.alarm else { return }
        datePicked.setDate(alarm.date, animated: false)
        alarmName.text = alarm.name
    }
    
    func updateAlarm(){
        if alarmIsOn {
            enableButton.setTitle("Turn OFF", for: .normal)
            enableButton.backgroundColor = .red
        } else {
            enableButton.setTitle("Turn ON", for: .normal)
            enableButton.backgroundColor = .green
        }
    }
}
