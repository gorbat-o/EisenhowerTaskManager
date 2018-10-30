//
//  Task.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 06/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import Foundation
import SwiftDate
import FirebaseDatabase

enum TaskCategory: Int {
    case dofirst = 0
    case toSchedule
    case toDelegate
    case toNotDo
    static var string = [
        L10n.Generic.doFirst,
        L10n.Generic.toSchedule,
        L10n.Generic.toDelegate,
        L10n.Generic.toNotDo
    ]
}

struct Task: Equatable {
    var databaseReference: DatabaseReference? {
        didSet {
            self.update()
        }
    }
    var title: String
    var description: String
    var category: TaskCategory
    var creationDate: Date
    var lastEditDate: Date
    var completionDate: Date?
    var completed: Bool

    init(snapshot: DataSnapshot) {
        self.init()
        databaseReference = snapshot.ref
        if let data = snapshot.value as? [String: AnyObject] {
            title = (data["title"] as? String) ?? ""
            description = (data["description"] as? String) ?? ""
            category = TaskCategory(rawValue: ((data["category"] as? Int) ?? 0)) ?? TaskCategory.dofirst
            creationDate = (data["creationDate"] as? String)?
                .toDate(style: StringToDateStyles.standard)?.date ?? Date()
            lastEditDate = (data["lastEditDate"] as? String)?
                .toDate(style: StringToDateStyles.standard)?.date ?? Date()
            completionDate = (data["completionDate"] as? String)?
                .toDate(style: StringToDateStyles.standard)?.date ?? Date()
            completed = Bool((data["completed"] as? String) ?? "") ?? false
        }
    }

    init() {
        title = "Task Title"
        description = "bla"
        category = TaskCategory.dofirst
        creationDate = Date()
        lastEditDate = Date()
        completionDate = nil
        completed = false
    }

    func update() {
        let taskObject = getObject()
        databaseReference?.setValue(taskObject["title"])
        databaseReference?.setValue(taskObject["description"])
        databaseReference?.setValue(taskObject["category"])
        databaseReference?.setValue(taskObject["creationDate"])
        databaseReference?.setValue(taskObject["lastEditDate"])
        databaseReference?.setValue(taskObject["completionDate"])
        databaseReference?.setValue(taskObject["completed"])
    }

    func getObject() -> [String: Any] {
        var task = [String: AnyObject]()
        task["title"] = title as NSString
        task["description"] = description as NSString
        task["category"] =  category.rawValue as AnyObject
        task["creationDate"] = creationDate.toString(DateToStringStyles.standard) as NSString
        task["lastEditDate"] = lastEditDate.toString(DateToStringStyles.standard) as NSString
        task["completionDate"] = completionDate?.toString(DateToStringStyles.standard) as NSString?
        task["completed"] = completed.description as NSString
        return task
    }
}

func == (lhs: Task, rhs: Task) -> Bool {
    return lhs.databaseReference == rhs.databaseReference
}
