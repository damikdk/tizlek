//
//  Figures.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 08.10.2022.
//

import SwiftUI

protocol Figure: Hashable, Identifiable {
  var id: UUID { get }
  var startTime: Double { get set }
  var duration: Double { get set }
  var color: Color { get set }
  
  var x: Double { get set }
  var y: Double { get set }
  
  var diameter: Double { get set }
}

struct OsuCircle: Figure {
  var id: UUID = UUID()
  var startTime: Double
  var duration: Double = 1
  var color: Color = .cyan
  
  var x: Double = .random(in: 50...300)
  var y: Double = .random(in: 50...800)
  
  var diameter: Double = .random(in: 90...200)
}
