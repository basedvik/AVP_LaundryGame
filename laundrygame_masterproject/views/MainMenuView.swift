import SwiftUI

struct MainMenuView: View {
    @Environment(GameState.self) private var game

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Laundry Ninja")
                    .font(.largeTitle).bold()
                Text("Fold fast. Score big.")
                    .foregroundStyle(.secondary)
            }

            Button(action: { game.startGame() }) {
                Text("Start Game")
                    .font(.headline)
                    .frame(maxWidth: 320)
                    .padding(.vertical, 14)
                    .background(.blue.gradient, in: .capsule)
                    .foregroundStyle(.white)
            }

            VStack(spacing: 10) {
                if game.bestScore > 0 {
                    Text("Best: \(game.bestScore)")
                        .font(.title3).bold()
                }
                Text("Tip: Tap items to fold them")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 8)
        }
        .padding(32)
    }
}

