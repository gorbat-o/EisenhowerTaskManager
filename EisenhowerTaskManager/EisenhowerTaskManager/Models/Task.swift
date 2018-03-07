//
//  Task.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 06/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import Foundation

enum TaskCategory {
    case dofirst
    case caseSchedule
    case delegate
    case dontDo
}

struct Task: Equatable {
    var id: UUID
    var title: String
    var description: String
    var category: TaskCategory
    var creationDate: Date
    var lastEditDate: Date
    var completionDate: Date?
    var completed: Bool
}

func == (lhs: Task, rhs: Task) -> Bool {
    return lhs.id == rhs.id
}
