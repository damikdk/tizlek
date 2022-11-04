//
//  ProgressLine.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 04.11.2022.
//

import SwiftUI

struct ProgressLine: View {
  var progress: Double
  
  var body: some View {
    GeometryReader { geometry in
      Rectangle()
        .fill(.white)
        .frame(width: 1)
        .offset(x: geometry.size.width * progress)
    }
  }
}
