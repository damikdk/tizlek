//
//  ContentView.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 17.09.2022.
//

import SwiftUI

struct Composition {
  let figures: [some Figure] = [
    OsuCircle(startTime: 1, duration: 2),
    OsuCircle(startTime: 2, duration: 0.5),
    OsuCircle(startTime: 3, duration: 3),
    OsuCircle(startTime: 4, duration: 3),
    OsuCircle(startTime: 5, duration: 3),
    OsuCircle(startTime: 5, duration: 1),
    OsuCircle(startTime: 6, duration: 2),
    OsuCircle(startTime: 7, duration: 2),
    OsuCircle(startTime: 9, duration: 5),
    OsuCircle(startTime: 10, duration: 30),
  ]
}

struct GameView: View {
  @State var composition = Composition()
  
  @State var startTime: Date = Date()
  @State var currentTime: Date = Date()
  
  @State var score: Int = 0
  let award: Int = 10
  
  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    let currentDuration = currentTime.timeIntervalSince(startTime)
    
    let neededFigures: [any Figure] = composition.figures.compactMap { figure in
      let figureFinish = startTime
        .advanced(by: figure.startTime)
        .advanced(by: figure.duration)
      
      if currentDuration > figure.startTime, currentTime < figureFinish {
        return figure
      }
      
      return nil
    }
    
    ZStack {
      
      // Figures itself
      ForEach(neededFigures, id: \.id) { figure in
        CircleView(figure: figure as! OsuCircle) { progress in
          score = score + Int(Double(award) * progress)
        }
      }
      
      // UI overlay
      VStack {
        Text("Score \(score)")
          .font(.title2)

        Text("\(currentDuration.formatted(.number.precision(.fractionLength(1))))")
        
        Spacer()
      }

    }
    .onReceive(timer) { _ in
      self.currentTime = Date()
    }
    
  }
}
