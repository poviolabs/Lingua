//
//  LinguaApp.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

@main
struct LinguaApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button(Lingua.App.about) {
          NSApplication.shared.orderFrontStandardAboutPanel(
            options: [
              NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                string: Lingua.App.description,
                attributes: [
                  NSAttributedString.Key.font: NSFont.boldSystemFont(
                    ofSize: NSFont.smallSystemFontSize)
                ]
              ),
              NSApplication.AboutPanelOptionKey(
                rawValue: Lingua.App.copyright
              ): Lingua.App.copyrightYear
            ]
          )
        }
      }
    }
  }
}
