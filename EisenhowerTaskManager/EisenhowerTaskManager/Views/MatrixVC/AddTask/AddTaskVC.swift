//
//  AddTaskVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 12/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftDate
import Eureka

class AddTaskVC: FormViewController {
    var task: Task?
    private var databaseHandle: DatabaseHandle?
    private let tasksChild = "users/\(Auth.auth().currentUser?.uid ?? "")/tasks"
    private var databaseReference: DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.createTask()
        self.setupTableView()
    }

    deinit {
        if let databaseHandle = self.databaseHandle {
            databaseReference?.removeObserver(withHandle: databaseHandle)
        }
    }
}

extension AddTaskVC {
    private func createTask() {
        databaseReference = Database.database().reference().child(self.tasksChild).childByAutoId()
        databaseReference?.observe(DataEventType.childAdded) { [weak self] snapshot in
            self?.task = Task(snapshot: snapshot)
        }
        databaseReference?.setValue(Task().getObject())
    }

    private func setupTableView() {
        self.form
            +++ Section()
            <<< TextRow("Title") { row in
                row.title = L10n.Generic.title
                row.placeholder = L10n.Action.putATitle
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
                row.value = task?.completed ?? false
                }.onChange { [weak self] row in
                    self?.changeCompleted(row.value ?? false)
                }
                .onCellSelection { [weak self] _, row in
                    self?.changeCompleted(row.value ?? false)
            }
            <<< TextAreaRow("Description") { row in
                row.placeholder = L10n.Generic.description
                row.value = task?.description ?? ""
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 200)
                }.cellUpdate { [weak self] _, row in
                    self?.changeDescription(row.value ?? "")
            }
            <<< ButtonRow("Cancel") { row in
                row.title = L10n.Generic.cancel
                }.onCellSelection { [weak self] _, _ in
                    self?.databaseReference?.removeValue()
                    self?.navigationController?.popViewController(animated: true)
                }
    }

    private func setupNavigationBar() {
        title = L10n.Generic.taskCreation
        setupNavigationBar(rightButtonWithTitle: L10n.Generic.done, andAction: #selector(rightButtonAction))
    }

    @objc private func rightButtonAction() {
        navigationController?.popViewController(animated: true)
    }

    private func changeTitle(_ title: String) {
        databaseReference?.child("title").setValue(title)
    }

    private func changeDescription(_ description: String) {
        databaseReference?.child("description").setValue(description)
    }

    private func changeCompleted(_ completed: Bool) {
        databaseReference?.child("completed").setValue(completed.description)
    }

    private func changeCompletionDate(_ date: Date?) {
        databaseReference?.child("completionDate").setValue(date?.string(format: DateFormat.iso8601Auto))
    }

    private func changeCategory(_ category: String) {
        databaseReference?.child("category").setValue(category)
    }
}
