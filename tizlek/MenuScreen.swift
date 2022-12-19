//
//  MenuScreen.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 22.11.2022.
//

import SwiftUI

struct MenuScreen: View {
  var compositions: [Composition]
  
  var body: some View {
    NavigationStack {

      List(compositions) { composition in
        NavigationLink(composition.name, value: composition)
      }
      .navigationDestination(for: Composition.self) { composition in
        GameView(composition: composition)
      }

    }
    
  }
}
