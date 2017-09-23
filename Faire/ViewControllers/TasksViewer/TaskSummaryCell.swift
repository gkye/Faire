//
//  TaskSummaryCell.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

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
    //REMINDME: change images
		icon.setImage(#imageLiteral(resourceName: "categoryIcon9"), for: .normal)
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

	@IBOutlet var checkBox: CheckBoxButton!
	@IBOutlet var titleLbl: UILabel!
	@IBOutlet var secondaryActionBtn: UIButton!

	override func awakeFromNib() {
    checkBox.boxType = .square
	}

	@IBAction func didTapCheckBox(sender: M13Checkbox){
		print("update realm model")
    taskCompleted()
	}

	func taskCompleted(){
		if model.isCompleted{
			let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: model.name)
			attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle, range: NSMakeRange(0, attributeString.length))
			attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.black, range: NSMakeRange(0, attributeString.length))

			titleLbl.attributedText = attributeString
      checkBox.setCheckState(.checked, animated: true)
//			checkBox.setSelected(true, animated: false)
		}
	}

	func updateUI(){
		titleLbl.text = model.name
		checkBox.toggleCheckState(model.isCompleted)
	}
}


