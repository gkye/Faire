//
//  TasksPreviewCell.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit
import IBAnimatable

class TasksPreviewCell: UICollectionViewCell {


	@IBOutlet var tasksTotalLbl: UILabel!
	@IBOutlet var tasksCategoryLbl: UILabel!
	@IBOutlet var moreBtn: UIButton!
	@IBOutlet var iconBtn: AnimatableButton!

	var model: TasksPreviewDisplayModel! {
		didSet {
			updateUI()
		}
	}
	override func awakeFromNib() {

		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
	}

	func updateUI(){
		tasksTotalLbl.text = model.totalTasksString
		tasksCategoryLbl.text = model.title
		iconBtn.setImage(model.icon, for: .normal)

	}
}
