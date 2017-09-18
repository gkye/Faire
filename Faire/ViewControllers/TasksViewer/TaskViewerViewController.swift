//
//  TaskViewerViewController.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import UIKit

class TaskViewerViewController: UITableViewController {

	var displayModel: TasksPreviewDisplayModel!
	var taskCategory: TaskCategory!

	var tasks: [Task] = []
	//Change navigation bar tint to white
	
	override func viewDidLoad() {
		super.viewDidLoad()
		taskCategory = displayModel.taskCategory
		tasks = Array(taskCategory.tasks)

		TaskDisplayModel.createModel(tasks: taskCategory.tasks[0])

	}


	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1 + tasks.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section > 0 {
			return tasks[section - 1].taskItems.count
		}
		return 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
			cell.model = tasks[indexPath.section - 1].taskItems[indexPath.row]
			return cell

		default:
			let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! TaskSummaryCell
			return cell
		}

	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section > 0 { return 50 }
		return 150
	}
}
