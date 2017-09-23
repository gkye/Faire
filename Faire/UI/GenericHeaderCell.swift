//
//  GenericHeaderCell.swift
//  Faire
//
//  Created by George Kye on 2017-09-23.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit

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
    headerLbl.text = "Label"
    headerLbl.contentMode = .left
    headerLbl.translatesAutoresizingMaskIntoConstraints = false
    headerLbl.font = UIFont(name: "Avenir-Medium", size: 15)
    headerLbl.textColor = UIColor(white: 0.667, alpha: 1)
    
    // Assemble View Hierarchy
    self.addSubview(headerLbl)
    
    // Configure Constraints
    headerLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
    headerLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    headerLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    viewCreated = true
  }
}
