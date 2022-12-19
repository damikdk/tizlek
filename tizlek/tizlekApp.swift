//
//  tizlekApp.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 17.09.2022.
//

import SwiftUI

@main
struct tizlekApp: App {
  let defaultCompositions = [
    Composition(figures: defaultComposition),
    Composition(figures: defaultSlowComposition)
  ]
  
    var body: some Scene {
        WindowGroup {
          MenuScreen(compositions: defaultCompositions)
//          EditorView()
//              .frame(minWidth: 300, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
        }
    }
}
