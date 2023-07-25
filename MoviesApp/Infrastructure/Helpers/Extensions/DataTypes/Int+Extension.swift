//
//  Int+Extension.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

extension Int {
    /*
  Convert Int number that represents amount of money to a string with amount type as suffix
   Usage example:
   337000000.asCurrencyString // Output: "337 mil"
   1000.asCurrencyString      // Output: "1K"
   10000.asCurrencyString     // Output: "10K"
   100000.asCurrencyString    // Output: "100K"
   999.asCurrencyString       // Output: "999"
   500.asCurrencyString       // Output: "500"
   */
  var asCurrencyString: String {
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
      numberFormatter.maximumFractionDigits = 1
      
      let absNumber = abs(self)
      
      var suffix = ""
      var formattedNumber = 0.0
      
      if absNumber >= 1_000_000 {
          formattedNumber = Double(absNumber) / 1_000_000.0
          suffix = " mil"
      } else if absNumber >= 1_000 {
          formattedNumber = Double(absNumber) / 1_000.0
          suffix = "K"
      } else if absNumber < 1_000 {
          formattedNumber = Double(self)
          suffix = absNumber < 0 ? " dollars" : ""
      }
      
      var formattedString = numberFormatter.string(from: NSNumber(value: formattedNumber)) ?? ""
      
      if formattedString == "0" {
          formattedString = "0"
      }
      
      return formattedString + suffix
  }

}
