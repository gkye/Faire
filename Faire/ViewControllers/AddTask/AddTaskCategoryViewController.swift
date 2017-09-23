//
//  AddTaskCategoryViewController.swift
//  Faire
//
//  Created by George Kye on 2017-09-20.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol IconCellDelegate {
	func iconCell(didSelect index: Int, cell: CategoryIconCell)
}

class AddTasksCategoryViewController: UIViewController {


	public var isUpdatable: Bool = false

	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var textField: UITextField!

	fileprivate var selectedIconIndex: Int = 0 {
		didSet {
			collectionView.reloadData()
		}
	}

	override func viewDidLoad() {
		textField.becomeFirstResponder()
		collectionView.register(CategoryIconCell.self, forCellWithReuseIdentifier: "iconCell")
		collectionView.dataSource = self
		collectionView.delegate = self
	}

}

extension AddTasksCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, IconCellDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		//Add icons to array later
		return 12
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! CategoryIconCell
		let img = UIImage(named: "categoryIcon\(indexPath.row)")
		cell.icon.setImage(img, for: .normal)
		cell.tag = indexPath.row

		if indexPath.row == selectedIconIndex {
			//REMINDME: Change colors
			cell.layer.borderWidth = 2
			cell.layer.borderColor = UIColor.blue.cgColor
		}else{
			cell.layer.borderWidth = 0
		}
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 60, height: 60)
	}

	fileprivate func iconCell(didSelect index: Int, cell: CategoryIconCell) {
		selectedIconIndex = index
	}

}


fileprivate class CategoryIconCell: UICollectionViewCell {

	var icon: UIButton!

	var delegate: IconCellDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		createView()
		layoutIfNeeded()
		self.layer.cornerRadius = 3
		self.layer.masksToBounds = true

		icon.isUserInteractionEnabled = true
		icon.addTarget(self, action: #selector(didTapIcon(sender:)), for: .touchUpInside)
	}


	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		UIView.animate(withDuration: 0.5,
		               delay: 0,
		               options: .curveEaseIn,
		               animations: {() -> Void in
										self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
										self.alpha = 0.7
		},
		               completion: nil
		)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		UIView.animate(withDuration: 0.5,
		               delay: 0,
		               options: .curveEaseIn,
		               animations: {() -> Void in
										self.transform = CGAffineTransform(scaleX: 1, y: 1)
										self.alpha = 1
		},
		               completion: nil
		)
	}



	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func createView(){
		icon = UIButton(type: .custom)

		icon.showsTouchWhenHighlighted = false
		icon.translatesAutoresizingMaskIntoConstraints = false

		// Assemble View Hierarchy
		self.addSubview(icon)

		// Configure Constraints
		icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		icon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: icon.trailingAnchor).isActive = true
	}

	func didTapIcon(sender: UIButton){
		delegate?.iconCell(didSelect: sender.tag, cell: self)
	}

}
