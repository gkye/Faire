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
	}

	@objc func didTapCheckBox(sender: AIFlatSwitch){
		print("update realm model")
	}

	func taskCompleted(){
		if model.isCompleted{
			let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: model.name)
			attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle, range: NSMakeRange(0, attributeString.length))
			attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.black, range: NSMakeRange(0, attributeString.length))

			titleLbl.attributedText = attributeString
			checkBox.setSelected(true, animated: false)
		}
	}

	func updateUI(){
		titleLbl.text = model.name
		checkBox.setSelected(model.isCompleted, animated: false)
	}
}


class GenericHeaderCell: UIView {

	var viewCreated: Bool = false

	var headerLbl: UILabel!

	override init(frame: CGRect) {
		super.init(frame: frame)
		createView()
		layoutIfNeeded()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func createView(){
		headerLbl = UILabel()
		headerLbl.textAlignment = .natural
		headerLbl.lineBreakMode = .byTruncatingTail
		headerLbl.baselineAdjustment = .alignBaselines
		headerLbl.text = "Label"
		headerLbl.contentMode = .left
		headerLbl.isOpaque = false
		headerLbl.translatesAutoresizingMaskIntoConstraints = false
		headerLbl.setContentHuggingPriority(251, for: .horizontal)
		headerLbl.setContentHuggingPriority(251, for: .vertical)
		headerLbl.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
		headerLbl.textColor = UIColor(white: 0.667, alpha: 1)

		// Assemble View Hierarchy
		self.addSubview(headerLbl)

		// Configure Constraints
		headerLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23.0).isActive = true
		headerLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		headerLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		viewCreated = true
	}
}
