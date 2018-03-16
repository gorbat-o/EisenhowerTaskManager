//
//  DetailedTaskVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 12/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import Eureka
import FirebaseDatabase
import FirebaseAuth
import SwiftDate

class DetailedTaskVC: FormViewController {
    var task: Task?
    private let tasksChild = "users/\(Auth.auth().currentUser?.uid ?? "")/tasks"
    private var databaseHandle: DatabaseHandle?

    deinit {
        if let databaseHandle = self.databaseHandle {
            Database.database().reference().child(self.tasksChild).removeObserver(withHandle: databaseHandle)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
}

extension DetailedTaskVC {
    private func setupNavigationBar() {
        title = task?.title ?? L10n.Generic.task
    }

    private func setupTableView() {
        self.form
            +++ Section()
            <<< TextRow("Title") { row in
                row.title = L10n.Generic.title
                row.value = task?.title
                }.cellUpdate { [weak self] _, row in
                    self?.changeTitle(row.value ?? "")
                }
            <<< ActionSheetRow<String>("Category") {
                $0.title = L10n.Generic.category
                $0.selectorTitle = L10n.Action.chooseTheCategory
                $0.options = TaskCategory.string
                $0.value = TaskCategory.string[task?.category.rawValue ?? 0]
                }.cellUpdate { [weak self] _, row in
                    self?.changeCategory(row.value ?? "")
            }
            <<< DateRow("CompletionDate") { row in
                row.title = L10n.Generic.for
                row.value = task?.completionDate
                }.cellUpdate { [weak self] _, row in
                    self?.changeCompletionDate(row.value)
            }
            <<< SwitchRow("Completed") { row in
                row.title = L10n.Generic.completed
                row.value = task?.completed
                }.onChange { [weak self] row in
                    self?.changeCompleted(row.value ?? false)
                }
                .onCellSelection { [weak self] _, row in
                    self?.changeCompleted(row.value ?? false)
                }
            <<< TextAreaRow("Description") { row in
                row.placeholder = L10n.Generic.description
                row.value = task?.description
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 200)
                }.cellUpdate { [weak self] _, row in
                    self?.changeDescription(row.value ?? "")
        }
    }

    private func changeTitle(_ title: String) {
        task?.databaseReference?.child("title").setValue(title)
    }

    private func changeDescription(_ description: String) {
        task?.databaseReference?.child("description").setValue(description)
    }

    private func changeCompleted(_ completed: Bool) {
        task?.databaseReference?.child("completed").setValue(completed.description)
    }

    private func changeCompletionDate(_ date: Date?) {
        task?.databaseReference?.child("completionDate").setValue(date?.string(format: DateFormat.iso8601Auto))
    }

    private func changeCategory(_ category: String) {
        task?.databaseReference?.child("category").setValue(category)
    }
}
