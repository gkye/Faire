//
//  AddTasksViewContoller.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit
import Hero

class AddTaskViewController: UIViewController {

	@IBOutlet	var taskTitleTextField: UITextField!
	@IBOutlet var optionsTableView: UITableView!

	public var taskParent: TaskCategory!{
		didSet {
			optionsDataSource[0].text = taskParent.name
		}
	}
	fileprivate var selectedDate = Date()
	public var taskItem: TaskItem?

	var addTaskBtn: UIBarButtonItem!

	typealias TaskOption = (image: UIImage, text: String)
	var optionsDataSource: [TaskOption] = [
		(image: #imageLiteral(resourceName: "groups"), text: "Personal"),
		(image: #imageLiteral(resourceName: "calendar"),  text: "Today"),
		(image: #imageLiteral(resourceName: "timeline"), text: "Set Reminder?")
	]

	override func viewDidLoad() {
		taskTitleTextField.becomeFirstResponder()
		taskTitleTextField.delegate = self

		optionsTableView.dataSource = self
		optionsTableView.delegate = self
		optionsTableView.register(TableViewCellWithLeftButton.self, forCellReuseIdentifier: "cell")

		addTaskBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapAddNewTaskBtn))
		addTaskBtn.isEnabled = false
		navigationItem.rightBarButtonItem = addTaskBtn
	}

	func didTapAddNewTaskBtn(){
		guard let title = taskTitleTextField.text else { return }
		//Change to user selected date

		let date = Date()
		let taskItem = TaskItem()
		taskItem.name = title
		taskItem.date = date
		TaskManager.addNewTask(category: taskParent, taskItem: taskItem)
		navigationController?.popViewController(animated: true)
	}
}

extension AddTaskViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return optionsDataSource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCellWithLeftButton
		cell.titleLbl.text = optionsDataSource[indexPath.row].text
		cell.leftButton.setImage(optionsDataSource[indexPath.row].image, for: .normal)
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		taskTitleTextField.resignFirstResponder()
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension AddTaskViewController: UITextFieldDelegate {

	func textFieldDidEndEditing(_ textField: UITextField) {
		toggleDoneBtn()
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		toggleDoneBtn()
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		toggleDoneBtn()
	}
	
	func toggleDoneBtn(){
		guard let txt = taskTitleTextField.text else{
			addTaskBtn.isEnabled = false
			return
		}
		if txt.isEmpty{
			addTaskBtn.isEnabled = false
		}else{
			addTaskBtn.isEnabled = true
		}
	}


}
