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

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		createCell()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func createCell(){

		self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

		leftButton = UIButton(type: .system)
		leftButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
		leftButton.isUserInteractionEnabled = false
		leftButton.isOpaque = false
		leftButton.translatesAutoresizingMaskIntoConstraints = false
		leftButton.setImage(UIImage(named: "groups"), for: .normal)

		titleLbl = UILabel()
		titleLbl.textAlignment = .natural
		titleLbl.lineBreakMode = .byTruncatingTail
		titleLbl.baselineAdjustment = .alignBaselines
		titleLbl.text = "Personal"
		titleLbl.contentMode = .left
		titleLbl.isOpaque = false
		titleLbl.translatesAutoresizingMaskIntoConstraints = false
		titleLbl.setContentHuggingPriority(251, for: .horizontal)
		titleLbl.setContentHuggingPriority(251, for: .vertical)
		titleLbl.font =  UIFont(name: "Avenir-Book", size: 18)
		titleLbl.textColor = UIColor(white: 0.333, alpha: 1)

		// Assemble View Hierarchy
		self.contentView.addSubview(leftButton)
		self.contentView.addSubview(titleLbl)

		// Configure Constraints
		leftButton.widthAnchor.constraint(equalToConstant: 22.0).isActive = true
		leftButton.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor).isActive = true
		leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		leftButton.bottomAnchor.constraint(equalTo: titleLbl.bottomAnchor).isActive = true
		titleLbl.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 8.0).isActive = true
		self.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 7.0).isActive = true

		// Remaining Configuration
		self.contentView.contentMode = .center
		self.contentView.isMultipleTouchEnabled = true
		self.contentView.isOpaque = false
		self.contentView.clipsToBounds = true
		self.contentView.autoresizingMask = []
	}
}



