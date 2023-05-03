//
//  CircleView.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 08.10.2022.
//

import SwiftUI

struct CircleView: View {
  var figure: OsuCircle
  var screenSize: CGSize
  var onTap: (Double) -> ()
  
  // TODO: This should be not just 0 or 1, but interpolated value.
  // But I don't know how to get current value of animated variable
  @State var progress: Double = 0
  @State var isTapped: Bool = false
  
//  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
      ZStack {
          Circle()
            .fill(.ultraThinMaterial)
        
          Circle()
          .strokeBorder(figure.color, lineWidth: isTapped ? figure.diameter / 3 : 15)
      }
        .frame(width: figure.diameter, height: figure.diameter)
        .clipped()

        .scaleEffect(1 - progress)
        .position(x: figure.x * screenSize.width, y: figure.y * screenSize.height)
        
        .opacity(isTapped ? 0 : 1)
        .disabled(isTapped)

//        .onTapGesture {
//          onTap(progress)
//
//          withAnimation(.linear(duration: 0.1)) {
//            isTapped = true
//            progress = 1
//          }
//        }
      
        .onLongPressGesture(minimumDuration: 0) {
          onTap(progress)
          
          withAnimation(.linear(duration: 0.1)) {
            isTapped = true
            progress = 1
          }
        }
            
        .onAppear {
          let baseAnimation = Animation.linear(duration: figure.duration)

          withAnimation(baseAnimation) {
            progress = 1
          }
        }
            
    }
}
