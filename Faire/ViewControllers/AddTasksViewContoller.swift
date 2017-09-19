//
//  AddTasksViewContoller.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit

class AddTasksViewContoller: UIViewController {


	@IBOutlet	var taskTitleTextField: UITextField!
	@IBOutlet var optionsTableView: UITableView!

	var taskParent: TaskCategory!
	var selectedDate = Date()
	var taskItem: TaskItem!

	typealias TaskOption = (image: UIImage, text: String)
	var optionsDataSource: [TaskOption] = [
		(image: #imageLiteral(resourceName: "groups"), text: "Personal"),
		(image: #imageLiteral(resourceName: "calendar"),  text: "Today"),
		(image: #imageLiteral(resourceName: "timeline"), text: "Set Reminder?")
	]


	override func viewDidLoad() {
		optionsTableView.register(TableViewCellWithLeftButton.self, forCellReuseIdentifier: "cell")
	}

}

extension AddTasksViewContoller: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return optionsDataSource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCellWithLeftButton
		cell.titleLbl.text = optionsDataSource[indexPath.row].text
		cell.leftButton.setImage(optionsDataSource[indexPath.row].image, for: .normal)
		return cell
	}
}
