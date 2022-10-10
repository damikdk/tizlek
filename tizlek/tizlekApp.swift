//
//  tizlekApp.swift
//  tizlek
//
//  Created by Damir Minnegalimov on 17.09.2022.
//

import SwiftUI

@main
struct tizlekApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
              .frame(minWidth: 500, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
        }
    }
}
