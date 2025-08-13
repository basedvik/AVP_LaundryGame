import SwiftUI

struct ResultsView: View {
    @Environment(GameState.self) private var game

    var body: some View {
        VStack(spacing: 16) {
            Text("Time Up!")
                .font(.title).bold()

            VStack(spacing: 6) {
                Label("Score: \(game.score)", systemImage: "star.fill")
                    .labelStyle(.titleAndIcon)
                    .foregroundStyle(.yellow)
                Text("Best: \(game.bestScore)")
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                Button("Play Again") { game.startGame() }
                    .buttonStyle(.borderedProminent)
                Button("Main Menu") { game.quitToMenu() }
                    .buttonStyle(.bordered)
            }
        }
        .padding(28)
        .background(.thinMaterial, in: .rect(cornerRadius: 20))
    }
}

