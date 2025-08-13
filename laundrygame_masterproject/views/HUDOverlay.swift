import SwiftUI

struct HUDOverlay: View {
    @Environment(GameState.self) private var game

    var body: some View {
        HStack {
            Label("\(game.score)", systemImage: "star.fill")
                .labelStyle(.iconOnly)
                .foregroundStyle(.yellow)
                .overlay(alignment: .leading) {
                    Text("\(game.score)")
                        .font(.headline)
                        .padding(.leading, 22)
                }

            Spacer()

            Group {
                Image(systemName: "timer")
                Text("\(game.timeRemaining)s")
            }
            .font(.headline)

            Spacer()

            Button(action: {
                game.pauseGame()
            }) {
                Label("Pause", systemImage: "pause.fill")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(12)
        .background(.thinMaterial, in: .rect(cornerRadius: 16))
        .padding()
    }
}

