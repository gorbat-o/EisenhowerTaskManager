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
            self.setupData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLabels()
    }
}

extension TaskTableViewCell {
    private func setupLabels() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.sizeToFit()
        self.lastEditDateLabel?.font = UIFont.systemFont(ofSize: 12)
        self.lastEditDateLabel?.sizeToFit()
        self.lastEditDateLabel?.textColor = UIColor.darkGray
    }

    private func setupData() {
        self.titleLabel?.text = self.task?.title
        if self.task?.lastEditDate.isToday ?? false {
            self.lastEditDateLabel?.text = task?.lastEditDate.string(dateStyle: .none, timeStyle: .short)
        } else {
            self.lastEditDateLabel?.text = task?.lastEditDate.string(dateStyle: .short, timeStyle: .short)
        }
    }
}
