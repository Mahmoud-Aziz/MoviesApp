//
//  Debounce.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class Debounce {
  private let interval: TimeInterval
  private var timer: Timer?
  
  init(delay: TimeInterval, completion: @escaping () -> Void) {
    self.interval = delay
    self.completion = completion
  }
  
  private var completion: (() -> Void)
  
  func resume() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
      self.completion()
    }
  }
  
  func invalidate() {
    timer?.invalidate()
    timer = nil
  }
}
