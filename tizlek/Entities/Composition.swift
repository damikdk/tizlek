//
//  Composition.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 17.10.2022.
//

import Foundation

struct Composition: Identifiable, Hashable {
  static func == (lhs: Composition, rhs: Composition) -> Bool {
    return lhs.id == rhs.id
  }
  
  let name: String = UUID().uuidString
  let figures: [any Figure]
  let duration: Double = defaultComposition.last!.startTime + defaultComposition.last!.duration
  var id = UUID()
}

let defaultComposition = [
  OsuCircle(startTime: 0, duration: 30, color: .red),

  OsuCircle(startTime: 1, duration: 2),
  OsuCircle(startTime: 1.3, duration: 2),
  OsuCircle(startTime: 2, duration: 0.5),
  OsuCircle(startTime: 2.5, duration: 1),
  OsuCircle(startTime: 2.7, duration: 1),
  OsuCircle(startTime: 3, duration: 2),
  OsuCircle(startTime: 3, duration: 2),
  OsuCircle(startTime: 4, duration: 2),
  OsuCircle(startTime: 4, duration: 2),
  OsuCircle(startTime: 5, duration: 2),
  OsuCircle(startTime: 5, duration: 1),
  OsuCircle(startTime: 6, duration: 2),
  OsuCircle(startTime: 6, duration: 2),
  OsuCircle(startTime: 7, duration: 2),
  OsuCircle(startTime: 7, duration: 2),
  OsuCircle(startTime: 8, duration: 1),
  OsuCircle(startTime: 8, duration: 1),
  OsuCircle(startTime: 9, duration: 4),
  OsuCircle(startTime: 9, duration: 4),
  
  OsuCircle(startTime: 10, duration: 30, color: .red),
  
  OsuCircle(startTime: 10, duration: 2, color: .gray),
  OsuCircle(startTime: 11, duration: 2, color: .gray),
  OsuCircle(startTime: 12, duration: 2, color: .gray),
  OsuCircle(startTime: 13, duration: 2, color: .gray),
  OsuCircle(startTime: 14, duration: 2, color: .gray),
  OsuCircle(startTime: 15, duration: 1),
  OsuCircle(startTime: 16, duration: 2),
  OsuCircle(startTime: 17, duration: 2, color: .blue),
  OsuCircle(startTime: 17, duration: 2, color: .blue),
  OsuCircle(startTime: 17, duration: 2, color: .blue),
  OsuCircle(startTime: 18, duration: 1, color: .blue),
  OsuCircle(startTime: 18, duration: 1, color: .blue),
  OsuCircle(startTime: 19, duration: 4),
  OsuCircle(startTime: 19, duration: 4),
  
  OsuCircle(startTime: 20, duration: 2),
  OsuCircle(startTime: 21, duration: 2, color: .indigo),
  OsuCircle(startTime: 22, duration: 2, color: .indigo),
  OsuCircle(startTime: 23, duration: 2, color: .indigo),
  OsuCircle(startTime: 24, duration: 2, color: .yellow),
  OsuCircle(startTime: 25, duration: 1, color: .indigo),
  OsuCircle(startTime: 26, duration: 2, color: .indigo),
  OsuCircle(startTime: 27, duration: 2, color: .indigo),
  OsuCircle(startTime: 27, duration: 2),
  OsuCircle(startTime: 27, duration: 2),
  OsuCircle(startTime: 28, duration: 1, color: .yellow),
  OsuCircle(startTime: 28, duration: 1, color: .yellow),
  OsuCircle(startTime: 29, duration: 4, color: .yellow),
  OsuCircle(startTime: 29, duration: 4),

  OsuCircle(startTime: 30, duration: 2, color: .yellow),
  OsuCircle(startTime: 31, duration: 2, color: .yellow),
  OsuCircle(startTime: 32, duration: 2),
  OsuCircle(startTime: 33, duration: 2),
  OsuCircle(startTime: 34, duration: 2),
  OsuCircle(startTime: 35, duration: 1),
  OsuCircle(startTime: 36, duration: 2),
  OsuCircle(startTime: 37, duration: 2),
  OsuCircle(startTime: 37, duration: 2),
  OsuCircle(startTime: 37, duration: 2),
  OsuCircle(startTime: 38, duration: 1),
  OsuCircle(startTime: 38, duration: 1),
  OsuCircle(startTime: 39, duration: 4),
  OsuCircle(startTime: 39, duration: 4),

]

let defaultSlowComposition = [
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .green),
  OsuCircle(startTime: 0, duration: 30, color: .yellow),
  OsuCircle(startTime: 0, duration: 30, color: .blue),
  OsuCircle(startTime: 0, duration: 30, color: .white),
  OsuCircle(startTime: 0, duration: 30, color: .cyan),
  
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .green),
  OsuCircle(startTime: 0, duration: 30, color: .yellow),
  OsuCircle(startTime: 0, duration: 30, color: .blue),
  OsuCircle(startTime: 0, duration: 30, color: .white),
  OsuCircle(startTime: 0, duration: 30, color: .cyan),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .green),
  OsuCircle(startTime: 0, duration: 30, color: .yellow),
  OsuCircle(startTime: 0, duration: 30, color: .blue),
  OsuCircle(startTime: 0, duration: 30, color: .white),
  OsuCircle(startTime: 0, duration: 30, color: .cyan),

  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .green),
  OsuCircle(startTime: 0, duration: 30, color: .yellow),
  OsuCircle(startTime: 0, duration: 30, color: .blue),
  OsuCircle(startTime: 0, duration: 30, color: .white),
  OsuCircle(startTime: 0, duration: 30, color: .cyan),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .green),
  OsuCircle(startTime: 0, duration: 30, color: .yellow),
  OsuCircle(startTime: 0, duration: 30, color: .blue),
  OsuCircle(startTime: 0, duration: 30, color: .white),
  OsuCircle(startTime: 0, duration: 30, color: .cyan),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .red),
  OsuCircle(startTime: 0, duration: 30, color: .green),
  OsuCircle(startTime: 0, duration: 30, color: .yellow),
  OsuCircle(startTime: 0, duration: 30, color: .blue),
  OsuCircle(startTime: 0, duration: 30, color: .white),
  OsuCircle(startTime: 0, duration: 30, color: .cyan),
  
]
