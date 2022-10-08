//
//  CircleView.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 08.10.2022.
//

import SwiftUI

struct CircleView: View {
  var figure: OsuCircle
  @State var progress: Double = 0
  
    var body: some View {
      Circle()
        .frame(width: figure.diameter, height: figure.diameter)
        .scaleEffect(1 - progress)
        .opacity(1 - progress)
        .position(x: figure.x, y: figure.y)
      
        .onAppear {
          let baseAnimation = Animation.linear(duration: figure.duration)

          withAnimation(baseAnimation) {
            progress = 1
          }
        }
    }
}
