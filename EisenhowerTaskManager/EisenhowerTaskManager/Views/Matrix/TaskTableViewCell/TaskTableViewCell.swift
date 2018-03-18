//
//  TaskTableViewCell.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 12/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import SwiftDate

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastEditDateLabel: UILabel!

    var task: Task? {
        didSet {
            setupData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupLabels()
    }
}

extension TaskTableViewCell {
    private func setupLabels() {
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleLabel?.sizeToFit()
        lastEditDateLabel?.font = UIFont.systemFont(ofSize: 12)
        lastEditDateLabel?.sizeToFit()
        lastEditDateLabel?.textColor = UIColor.darkGray
    }

    private func setupData() {
        titleLabel?.text = task?.title
        if task?.lastEditDate.isToday ?? false {
            lastEditDateLabel?.text = task?.lastEditDate.string(dateStyle: .none, timeStyle: .short)
        } else {
            lastEditDateLabel?.text = task?.lastEditDate.string(dateStyle: .short, timeStyle: .short)
        }
    }
}
