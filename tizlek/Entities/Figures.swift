//
//  Figures.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 08.10.2022.
//

import SwiftUI

class Figure: Hashable, Identifiable, Equatable {
  var id: UUID = UUID()
  var startTime: Double
  var duration: Double
  var color: Color

  var x: Double
  var y: Double
  
  init(
    id: UUID = UUID() ,
    startTime: Double!,
    duration: Double = 1,
    color: Color = .white,
    x: Double = .random(in: 0...1),
    y: Double = .random(in: 0...1)
  ) {
    self.id = id
    self.startTime = startTime
    self.duration = duration
    self.color = color
    self.x = x
    self.y = y
  }
  
  static func == (lhs: Figure, rhs: Figure) -> Bool {
    return lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
      return hasher.combine(id)
  }
}

class OsuCircle: Figure {
  
  var diameter: Double = .random(in: 90...200)

}
