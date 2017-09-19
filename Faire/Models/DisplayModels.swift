//
//  DisplayModels.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit
import Timepiece

struct TasksPreviewDisplayModel {

	var taskCategory: TaskCategory!

	var title: String!
	var totalTasksString: String!
	var totalTasks:Int!
	var completedTasks: Double!
	var incompleteTasks: Double!
	var icon: UIImage! = #imageLiteral(resourceName: "playground")

	init(task: TaskCategory) {
		self.title = task.name
		totalTasks = task.tasks.flatMap({$0.taskItems}).count
		totalTasksString = "\(totalTasks!) Tasks"
		icon = UIImage(named: task.icon)
		taskCategory = task
	}
}

struct TaskDisplayModel {

	var dateString: String! = ""
	var items = [TaskItemDisplayModel]()

	static func createModel(tasks: Task) -> TaskDisplayModel {
		var model = TaskDisplayModel()

		model.dateString = tasks.rawDate.toString()
		tasks.taskItems.forEach {
			task in
			let item = TaskItemDisplayModel(item: task)
			model.items.append(item)
		}
		return model
	}
}


struct TaskItemDisplayModel {

	var title: String!
	var item: TaskItem!

	init(item: TaskItem){
		title = item.name
		self.item = item
	}
}
