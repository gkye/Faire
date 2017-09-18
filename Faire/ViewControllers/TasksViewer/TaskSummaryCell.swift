//
//  TaskSummaryCell.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit

class TaskSummaryCell: UITableViewCell{

	@IBOutlet var icon: UIButton!
	@IBOutlet var tasksCountLbl: UILabel!
	@IBOutlet var tasksCategoryLbl: UILabel!
	@IBOutlet var progressBar: UIProgressView!

	var displayModel: TasksPreviewDisplayModel!{
		didSet {
			updateUI()
		}
	}

	func updateUI(){
		icon.setImage(displayModel.icon, for: .normal)
		tasksCountLbl.text = displayModel.totalTasksString
		tasksCategoryLbl.text = displayModel.title
	}
}


class TaskCell: UITableViewCell {

	var model: TaskItem!{
		didSet{
			updateUI()
		}
	}

	@IBOutlet var checkBox: AIFlatSwitch!
	@IBOutlet var titleLbl: UILabel!
	@IBOutlet var secondaryActionBtn: UIButton!

	override func awakeFromNib() {
		checkBox.addTarget(self, action: #selector(didTapCheckBox), for: .touchUpInside)
	}

	@objc func didTapCheckBox(sender: AIFlatSwitch){
		print("update realm model")
	}

	func taskCompleted(){
		if model.isCompleted{
			//add strikeout and select
		}
	}

	func updateUI(){
		titleLbl.text = model.name
		checkBox.setSelected(model.isCompleted, animated: false)
	}
}
