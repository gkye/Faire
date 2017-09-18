//
//  TaskManager.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import RealmSwift

struct TaskManager {

	@discardableResult static func createNewCategory(name: String, icon: String) -> TaskCategory{
		let realm = try! Realm()
		let category = TaskCategory()
		category.name = name
		category.id = UUID().uuidString
		try! realm.write {
			realm.add(category)
		}
		return category
	}

	static func getAllTasks() -> [TaskCategory] {
		let realm = try! Realm()
		let arr: [TaskCategory] = Array(realm.objects(TaskCategory.self))
		return arr
	}

	static func addNewTask(category: TaskCategory, taskItem: TaskItem){
		let realm = try! Realm()
		let categories = getAllTasks()

		let cat = categories.first(where: {
			$0.id == taskItem.parentId
		})


		guard let taskParent = cat else { return }
		if let sameDateTask = taskParent.tasks.first(where: {taskItem.date.isSameDay(as: $0.rawDate)}) {
			try! realm.write {
				sameDateTask.taskItems.append(taskItem)
			}
		}else{
			let taskObject = Task()
			taskObject.rawDate = taskItem.date
			try! realm.write {
				taskObject.taskItems.append(taskItem)
				category.tasks.append(taskObject)
			}
		}
	}
	
}

extension TaskItem {
	static func createItem(name: String, date: Date, parentTask: TaskCategory) -> TaskItem {
		let task = TaskItem()
		task.name = name
		task.isCompleted = false
		task.id = UUID().uuidString
		task.date = date
		task.parentId = parentTask.id
		return task
	}
}
