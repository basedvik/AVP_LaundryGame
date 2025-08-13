import SwiftUI

struct PauseOverlay: View {
    @Environment(GameState.self) private var game

    var body: some View {
        ZStack {
            Color.black.opacity(0.25).ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Paused").font(.title2).bold()
                HStack(spacing: 12) {
                    Button("Resume") { game.resumeGame() }
                        .buttonStyle(.borderedProminent)
                    Button("Quit") { game.quitToMenu() }
                        .buttonStyle(.bordered)
                }
            }
            .padding(24)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
        }
        .transition(.opacity)
    }
}

