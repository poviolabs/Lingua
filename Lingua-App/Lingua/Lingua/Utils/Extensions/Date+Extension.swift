//
//  Date+Extension.swift
//  Lingua
//
//  Created by Egzon Arifi on 24/08/2023.
//

import Foundation

extension Date {
  var formatted: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: self)
  }
}
