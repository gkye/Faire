//
//  DesignableView.swift
//  Faire
//
//  Created by George Kye on 2017-09-23.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class DesignableView: UIView {

	@IBInspectable var addShadow: Bool = false{
		didSet {
			configureAppearance()
		}
	}

	@IBInspectable var cornerRadius: CGFloat = 2 {
		didSet {
			configureAppearance()
		}
	}

	@IBInspectable var shadowOffsetWidth: Int = 0 {
		didSet {
			configureAppearance()
		}
	}

	@IBInspectable var shadowOffsetHeight: Int = Int(0.5){
		didSet {
			configureAppearance()
		}
	}

	@IBInspectable var shadowColor: UIColor? = UIColor.black{
		didSet {
			configureAppearance()
		}
	}

	@IBInspectable var shadowOpacity: Float = 0.5{
		didSet {
			configureAppearance()
		}
	}

	override func layoutSubviews() {
		configureAppearance()

	}

	func configureAppearance(){
		layer.cornerRadius = cornerRadius
		let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
		layer.masksToBounds = false
		layer.shadowColor = shadowColor?.cgColor
		layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
		layer.shadowOpacity = shadowOpacity
		layer.shadowPath = shadowPath.cgPath
	}
}

