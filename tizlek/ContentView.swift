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
    OsuCircle(startTime: 3, duration: 2),
    OsuCircle(startTime: 5, duration: 2),
    OsuCircle(startTime: 9, duration: 5),
    OsuCircle(startTime: 10, duration: 30),
  ]
}

struct ContentView: View {
  @State var composition = Composition()
  @State var startTime: Date = Date()
  @State var currentTime: Date = Date()
  
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
      Text("\(currentDuration.rounded())")
      
      ForEach(neededFigures, id: \.id) { figure in
        
        CircleView(figure: figure as! OsuCircle)
      }
    }
    .onReceive(timer) { _ in
      self.currentTime = Date()
    }
    
  }
}
