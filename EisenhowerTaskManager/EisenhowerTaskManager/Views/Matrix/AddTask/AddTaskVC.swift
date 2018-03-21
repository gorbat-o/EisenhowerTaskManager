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
    private var isModified = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        createTask()
        setupTableView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if !isModified {
            databaseReference?.removeValue()
        }
    }

    deinit {
        if let databaseHandle = databaseHandle {
            databaseReference?.removeObserver(withHandle: databaseHandle)
        }
    }
}

extension AddTaskVC {
    private func createTask() {
        databaseReference = Database.database().reference().child(tasksChild).childByAutoId()
        databaseReference?.observe(DataEventType.childAdded) { [weak self] snapshot in
            self?.task = Task(snapshot: snapshot)
        }
        databaseReference?.setValue(Task().getObject())
    }

    private func setupTableView() {
        form
            +++ Section()
            <<< TextRow("Title") { row in
                row.title = L10n.Generic.title
                row.placeholder = L10n.Action.putATitle
                }.cellUpdate { [weak self] _, row in
                    self?.changeTitle(row.value ?? "")
                }.onCellSelection { [weak self] _, _ in
                    self?.isModified = true
                }
            <<< ActionSheetRow<String>("Category") {
                $0.title = L10n.Generic.category
                $0.selectorTitle = L10n.Action.chooseTheCategory
                $0.options = TaskCategory.string
                $0.value = TaskCategory.string[task?.category.rawValue ?? 0]
                }.cellUpdate { [weak self] _, row in
                    self?.changeCategory(row.value ?? "")
                }.onCellSelection { [weak self] _, _ in
                    self?.isModified = true
            }
            <<< DateRow("CompletionDate") { row in
                row.title = L10n.Generic.for
                row.value = task?.completionDate
                }.cellUpdate { [weak self] _, row in
                    self?.changeCompletionDate(row.value)
                }.onCellSelection { [weak self] _, row in
                    row.value = Date()
                    row.updateCell()
                    self?.isModified = true
            }
            <<< SwitchRow("Completed") { row in
                row.title = L10n.Generic.completed
                row.value = task?.completed ?? false
                }.onChange { [weak self] row in
                    self?.changeCompleted(row.value ?? false)
                }.onCellSelection { [weak self] _, _ in
                    self?.isModified = true
            }
            <<< TextAreaRow("Description") { row in
                row.placeholder = L10n.Generic.description
                row.value = task?.description ?? ""
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 200)
                }.cellUpdate { [weak self] _, row in
                    self?.changeDescription(row.value ?? "")
                }.onCellSelection { [weak self] _, _ in
                    self?.isModified = true
            }
            +++ ButtonRow("Cancel") { row in
                row.title = L10n.Generic.cancel
                row.cell.tintColor = UIColor.red
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
