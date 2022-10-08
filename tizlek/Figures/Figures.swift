//
//  Figures.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 08.10.2022.
//

import Foundation

protocol Figure: Hashable, Identifiable {
  var id: UUID { get }
  var startTime: Double { get set }
  var duration: Double { get set }
  
  var x: Double { get set }
  var y: Double { get set }
  
  var diameter: Double { get set }
}

struct OsuCircle: Figure {
  var id: UUID = UUID()
  var startTime: Double
  var duration: Double = 1
  
  var x: Double = .random(in: 0...500)
  var y: Double = .random(in: 0...500)
  
  var diameter: Double = .random(in: 35...50)
}
