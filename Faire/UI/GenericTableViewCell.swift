//
//  GenericTableViewCell.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellWithLeftButton: UITableViewCell {


	var leftButton: UIButton!
	var titleLbl: UILabel!

	func createCell(){

		self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

		let button = UIButton(type: .custom)
		button.titleLabel?.lineBreakMode = .byTruncatingMiddle
		button.isUserInteractionEnabled = false
		button.isOpaque = false
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "groups"), for: .normal)

		let label = UILabel()
		label.textAlignment = .natural
		label.lineBreakMode = .byTruncatingTail
		label.baselineAdjustment = .alignBaselines
		label.text = "Personal"
		label.contentMode = .left
		label.isOpaque = false
		label.translatesAutoresizingMaskIntoConstraints = false
		label.setContentHuggingPriority(251, for: .horizontal)
		label.setContentHuggingPriority(251, for: .vertical)
		label.font = UIFont(name: "HelveticaNeue", size: 17)
		label.textColor = UIColor(white: 0.333, alpha: 1)

		// Assemble View Hierarchy
		self.contentView.addSubview(button)
		self.contentView.addSubview(label)

		// Configure Constraints
		button.widthAnchor.constraint(equalToConstant: 22.0).isActive = true
		label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 15.0).isActive = true
		button.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
		label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
		button.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
		button.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
		button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true

		// Remaining Configuration
		self.contentView.contentMode = .center
		self.contentView.isMultipleTouchEnabled = true
		self.contentView.isOpaque = false
		self.contentView.clipsToBounds = true
		self.contentView.autoresizingMask = []
	}
}
