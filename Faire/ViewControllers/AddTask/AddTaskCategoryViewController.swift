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
  
  var doneBtn: UIBarButtonItem!
  
  override func viewDidLoad() {
    
    doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(addNewCategory))
    navigationItem.rightBarButtonItem = doneBtn
    
    textField.becomeFirstResponder()
    collectionView.register(CategoryIconCell.self, forCellWithReuseIdentifier: "iconCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.isUserInteractionEnabled = true
  }
  
  
  func addNewCategory(){
    guard let text = textField.text else {
      print("create error view")
      return
    }
    let iconString = "categoryIcon\(selectedIconIndex)"
    TaskManager.createNewCategory(name: text, icon: iconString)
    navigationController?.popViewController(animated: true)
  }
}

extension AddTasksCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //Add icons to array later
    return 12
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! CategoryIconCell
    let img = UIImage(named: "categoryIcon\(indexPath.row)")
    cell.icon.image = img
    cell.tag = indexPath.row
    
    if indexPath.row == selectedIconIndex {
      //REMINDME: Change colors
      cell.layer.borderWidth = 1
      cell.layer.borderColor = UIColor.blue.cgColor
    }else{
      cell.layer.borderWidth = 0
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIconIndex = indexPath.row
    print("selected")
  }
  
  
}


fileprivate class CategoryIconCell: UICollectionViewCell {
  
  var icon: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    createView()
    layoutIfNeeded()
    self.layer.cornerRadius = 3
    self.layer.masksToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func createView(){
    icon = UIImageView()
    icon.contentMode = .center
    icon.translatesAutoresizingMaskIntoConstraints = false
    
    // Assemble View Hierarchy
    self.addSubview(icon)
    
    // Configure Constraints
    icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    icon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.trailingAnchor.constraint(equalTo: icon.trailingAnchor).isActive = true
  }
}
