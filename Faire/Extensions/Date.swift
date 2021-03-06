//
//  Date.swift
//  Faire
//
//  Created by George Kye on 2017-09-18.
//  Copyright © 2017 George Kye. All rights reserved.
//

import Foundation
import Timepiece


fileprivate let formatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateFormat = "dd/MM/yyyy"
	formatter.locale = Locale.current
	return formatter
}()

extension Date {

	func isSameDay(as otherDate: Date) -> Bool {
		let order = Calendar.current.compare(self, to: otherDate, toGranularity: .day)
		switch order {
		case .orderedSame: return true
		default: return false
		}
	}

	func toString(format: String = "MMM d, yyyy") -> String{

		if self.isSameDay(as: Date()){
			return "Today"
		}

		if self.isSameDay(as: Date.yesterday()){
			return "Yesterday"
		}

		let components = getComponents(secondDate: self)
		if components.day ?? 0 < 4 {
			return self.formatDateToString(format: "EEEE")
		}

		return self.formatDateToString(format: format)
	}

	func getComponents(secondDate: Date) -> DateComponents{
		let calendar = Calendar.current
		// Replace the hour (time) of both dates with 00:00
		let date1 = calendar.startOfDay(for: secondDate)
		let date2 = calendar.startOfDay(for: Date())
		return  calendar.dateComponents([.day, .calendar], from: date1, to: date2)
	}

	public func formatDateToString(format: String) -> String{
		formatter.dateFormat = format
		let stringDate = formatter.string(from: self)
		return stringDate
	}
}


