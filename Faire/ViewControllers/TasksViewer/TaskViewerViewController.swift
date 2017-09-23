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
	var dataSource = [TaskDisplayModel]()

	//Change navigation bar tint to white

	override func viewDidLoad() {
		super.viewDidLoad()
		let addTaskBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(didTapAddNewTask))
		addTaskBtn.tintColor = .black
		navigationItem.rightBarButtonItem = addTaskBtn
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		//REMINDME: Replace with notifcation later?
		loadData()
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.barTintColor = .white
	}

	func loadData(refresh: Bool = false){
		if refresh {
			guard let updatedData = TaskManager.getAllTasks().first(where: {
				$0.id == taskCategory.id
			})else { return }

			self.taskCategory = updatedData
		}

		taskCategory = displayModel.taskCategory
		tasks = Array(taskCategory.tasks)
		tasks.sort(by: {
			$0.0.rawDate > $0.1.rawDate
		})

		tasks.forEach({
			let model = TaskDisplayModel.createModel(tasks: $0)
			dataSource.append(model)
		})
		tableView.reloadData()
	}

	func didTapTaskCompleted(sender: AIFlatSwitch){
		if let indexPath = sender.indexPath{
			let item = tasks[indexPath.section - 1].taskItems[indexPath.row]
			//Negate current completion status
			TaskManager.toggleTaskCompletionStatus(task: item)
		}
	}

	func didTapAddNewTask(){
		let storyB = UIStoryboard(name: "AddTask", bundle: nil)
		let vc = storyB.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
		vc.taskParent = taskCategory
		navigationController?.pushViewController(vc, animated: true)

	}
}
extension TaskViewerViewController {
	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1 + dataSource.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section > 0 {
			return dataSource[section - 1].items.count
		}
		return 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! TaskSummaryCell
      cell.displayModel = displayModel
			return cell

		default:
			let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
			cell.model = dataSource[indexPath.section - 1].items[indexPath.row].item
			cell.checkBox.indexPath = indexPath
			cell.checkBox.addTarget(self, action: #selector(didTapTaskCompleted(sender:)), for: .touchUpInside)
			return cell
		}

	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = GenericHeaderCell(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 25))
		if section == 0 { return nil }
		header.headerLbl.text = dataSource[section - 1].dateString
		return header
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section > 0 { return 32 }
		return 80
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 0 { return 0 }
		return 40
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
