//
//  AlarmListTableViewController.swift
//  Alarm2
//
//  Created by Jordan Furr on 3/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.alarm = alarm
        cell.delegate = self
        return cell
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let destinationVC = segue.destination as? DetailTableViewController {
                if let index = tableView.indexPathForSelectedRow {
                    let alarm = AlarmController.shared.alarms[index.row]
                    destinationVC.alarm = alarm
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(for cell: SwitchTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.shared.alarms[index.row]
        AlarmController.toggleIsON(for: alarm)
        cell.updateViews()
        tableView.reloadData()
    }
    
}
