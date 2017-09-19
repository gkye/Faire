//
//  ViewController.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

	@IBOutlet var collectionView: UICollectionView!

	var dataSource: [TaskCategory] = []
	var displayModel: [TasksPreviewDisplayModel] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		collectionView.delegate = self
 		loadData()
	}

	func loadData(){
		dataSource = TaskManager.getAllTasks()
		dataSource.forEach{ task in
			let model = TasksPreviewDisplayModel(task: task)
			displayModel.append(model)
		}
		collectionView.reloadData()

	}

	func createTestingData(){
//		TaskManager.createNewCategory(name: "Personal", icon: "playground")
		let now = Date()

		let arr = ["Fuck ya mum"]
		let cat = TaskManager.getAllTasks()[0]
		for i in arr {
			let item = TaskItem.createItem(name: i, date: 3.weeks.ago!, parentTask: cat)
			TaskManager.addNewTask(category: cat, taskItem: item)
		}
		let items = TaskManager.getAllTasks()

		print(items)
	}

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return displayModel.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TasksPreviewCell
		cell.model = displayModel[indexPath.row]
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (collectionView.bounds.width / 2) - 5, height: 250)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "TaskViewer", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "TaskViewerViewController") as! TaskViewerViewController
		vc.displayModel = displayModel[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
}

