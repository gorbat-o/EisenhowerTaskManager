//
//  MatrixVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 11/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftDate

class MatrixVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    private var databaseHandle: DatabaseHandle?
    private let tasksChild = "users/\(Auth.auth().currentUser?.uid ?? "")/tasks"
    private let titleSections: [String] = TaskCategory.string
    private var completedTasks: [TaskCategory: [Task]] = [
        .dofirst: [Task](),
        .toSchedule: [Task](),
        .toDelegate: [Task](),
        .toNotDo: [Task]()
    ]
    private var incompleteTasks: [TaskCategory: [Task]] = [
        .dofirst: [Task](),
        .toSchedule: [Task](),
        .toDelegate: [Task](),
        .toNotDo: [Task]()
    ]
    private var allTasks: [TaskCategory: [Task]] = [
        .dofirst: [Task](),
        .toSchedule: [Task](),
        .toDelegate: [Task](),
        .toNotDo: [Task]()
    ]
    private var tasks = [Task]() {
        didSet {
            allTasks[TaskCategory.dofirst] = tasks.filter { $0.category == TaskCategory.dofirst }
            allTasks[TaskCategory.toSchedule] = tasks.filter { $0.category == TaskCategory.toSchedule }
            allTasks[TaskCategory.toDelegate] = tasks.filter { $0.category == TaskCategory.toDelegate }
            allTasks[TaskCategory.toNotDo] = tasks.filter { $0.category == TaskCategory.toNotDo }
            setupTasks()
        }
    }

    deinit {
        if let databaseHandle = databaseHandle {
            Database.database().reference().child(tasksChild).removeObserver(withHandle: databaseHandle)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSegmentedControl()
        setupTableView()
        setupRefreshControl()
        setupFirebase()
    }

    @IBAction func indexChanged(_ sender: AnyObject) {
        tableView?.reloadData()
    }
}

extension MatrixVC {
    private func setupNavigationBar() {
        title = L10n.Generic.matrix
        setupNavigationBar(rightButtonWithTitle: L10n.Generic.add, andAction: #selector(rightButtonAction))
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(updateData), for: UIControlEvents.valueChanged)
        tableView?.refreshControl = refreshControl
    }

    @objc private func updateData() {
        tableView?.reloadData()
        refreshControl.endRefreshing()
    }

    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: L10n.Generic.completed, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: L10n.Generic.incomplete, at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: L10n.Generic.all, at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
    }

    private func setupTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(
            UINib(nibName: "TaskTableViewCell", bundle: nil),
            forCellReuseIdentifier: "TaskTableViewCell"
        )
    }

    private func setupFirebase() {
        databaseHandle = Database.database().reference().child(tasksChild)
            .observe(DataEventType.value) { [weak self] snapshot in
                self?.tasks.removeAll()
                snapshot.children.forEach { child in
                    if let dataSnapshot = child as? DataSnapshot {
                        let task = Task(snapshot: dataSnapshot)
                        self?.tasks.append(task)
                    }
                }
                self?.tableView?.reloadData()
        }
    }

    private func setupTasks() {
        completedTasks[.dofirst] = allTasks[.dofirst]?.filter { $0.completed == true }
        completedTasks[.toSchedule] = allTasks[.toSchedule]?.filter { $0.completed == true }
        completedTasks[.toDelegate] = allTasks[.toDelegate]?.filter { $0.completed == true }
        completedTasks[.toNotDo] = allTasks[.toNotDo]?.filter { $0.completed == true }
        incompleteTasks[.dofirst] = allTasks[.dofirst]?.filter { $0.completed == false }
        incompleteTasks[.toSchedule] = allTasks[.toSchedule]?.filter { $0.completed == false }
        incompleteTasks[.toDelegate] = allTasks[.toDelegate]?.filter { $0.completed == false }
        incompleteTasks[.toNotDo] = allTasks[.toNotDo]?.filter { $0.completed == false }
        allTasks[.dofirst] = tasks.filter { $0.category == TaskCategory.dofirst }
        allTasks[.toSchedule] = tasks.filter { $0.category == TaskCategory.toSchedule }
        allTasks[.toDelegate] = tasks.filter { $0.category == TaskCategory.toDelegate }
        allTasks[.toNotDo] = tasks.filter { $0.category == TaskCategory.toNotDo }
    }

    @objc private func rightButtonAction() {
        let addTaskVC = AddTaskVC()
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
}

extension MatrixVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectedSegmentIndex = segmentedControl?.selectedSegmentIndex,
            let category = TaskCategory(rawValue: section) {
            switch selectedSegmentIndex {
            case 0:
                return completedTasks[category]?.count ?? 0
            case 1:
                return incompleteTasks[category]?.count ?? 0
            case 2:
                return allTasks[category]?.count ?? 0
            default:
                break
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleSections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell
        if let selectedSegmentIndex = segmentedControl?.selectedSegmentIndex,
            let category = TaskCategory(rawValue: indexPath.section) {
            switch selectedSegmentIndex {
            case 0:
                cell?.task = completedTasks[category]?[indexPath.row]
            case 1:
                cell?.task = incompleteTasks[category]?[indexPath.row]
            case 2:
                cell?.task = allTasks[category]?[indexPath.row]
            default:
                break
            }
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailedTaskVC = DetailedTaskVC()
        if let category = TaskCategory(rawValue: indexPath.section) {
            detailedTaskVC.task = allTasks[category]?[indexPath.row]
        }
        navigationController?.pushViewController(detailedTaskVC, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let selectedSegmentIndex = segmentedControl?.selectedSegmentIndex,
                let category = TaskCategory(rawValue: indexPath.section) {
                switch selectedSegmentIndex {
                case 0:
                    completedTasks[category]?[indexPath.row].databaseReference?.removeValue()
                case 1:
                    incompleteTasks[category]?[indexPath.row].databaseReference?.removeValue()
                case 2:
                    allTasks[category]?[indexPath.row].databaseReference?.removeValue()
                default:
                    break
                }
            }
        }
    }
}
