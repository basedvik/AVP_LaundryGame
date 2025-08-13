//
//  ContentView.swift
//  laundrygame_masterproject
//
//  Created by Vikram Bhaduri on 7/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var game = GameState()

    var body: some View {
        ZStack {
            switch game.phase {
            case .menu:
                MainMenuView()
                    .environment(game)

            case .playing:
                GameView()
                    .environment(game)

            case .paused:
                GameView()
                    .environment(game)

            case .results:
                resultsLayer
            }

            // Optional immersive toggle lives in top-right for convenience
            VStack { HStack { Spacer(); ToggleImmersiveSpaceButton() }; Spacer() }
                .padding()
        }
    }

    private var resultsLayer: some View {
        ZStack {
            GameView().blur(radius: 8).environment(game)
            ResultsView().environment(game)
        }
        .transition(.opacity)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
