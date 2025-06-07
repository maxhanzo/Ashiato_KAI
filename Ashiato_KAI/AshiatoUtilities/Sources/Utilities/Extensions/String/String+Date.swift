//
//  String+Date.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 06/05/25.
//

import Foundation

extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Date format is not yyyy-MM-dd")
    }
    return date
  }
}
