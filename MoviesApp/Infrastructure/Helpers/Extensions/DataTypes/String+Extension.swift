//
//  String+Extension.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

extension String {
  static var notAvailable = "n/a"

  var extractedYearFromStringDate: Self? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    guard let date = dateFormatter.date(from: self) else {
      return nil
    }
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    return String(year)
  }
}
