//
//  Task.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import RealmSwift

class TaskCategory: Object {
	dynamic var name = ""
	dynamic var id = ""
	let tasks = List<Task>()
	dynamic var icon = ""

	override static func primaryKey() -> String? {
		return "id"
	}
}

class Task: Object{
	let taskItems = List<TaskItem>()
	dynamic var rawDate: Date!
}

/// Object within each transaction.
class TaskItem: Object{

	dynamic var name = ""
	dynamic var id = ""
	dynamic var isCompleted = false
	dynamic var notes: String? = ""
	dynamic var date: Date!
	//To easier find which account it belongs to for editing and deleting
	dynamic var parentId = ""

	override static func primaryKey() -> String? {
		return "id"
	}
}



