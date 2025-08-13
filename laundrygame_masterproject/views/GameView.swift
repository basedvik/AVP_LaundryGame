import SwiftUI

struct GameView: View {
    @Environment(GameState.self) private var game

    var body: some View {
        ZStack {
            // Playfield background
            LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            // Items layer
            GeometryReader { geo in
                ZStack {
                    ForEach(game.items) { item in
                        LaundryItemView(item: item) {
                            game.fold(item: item)
                        }
                        .position(adjustedPosition(item.position, in: geo.size))
                    }
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: game.items)
            }

            VStack {
                HUDOverlay()
                Spacer()

                // Simple combo banner
                if game.combo >= 2 {
                    Text("Combo x\(game.combo)")
                        .font(.headline)
                        .padding(.horizontal, 14).padding(.vertical, 8)
                        .background(.ultraThinMaterial, in: .capsule)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom)
                }
            }

            if game.phase == .paused {
                PauseOverlay()
            }
        }
    }

    private func adjustedPosition(_ point: CGPoint, in size: CGSize) -> CGPoint {
        // Constrain to bounds
        CGPoint(x: min(max(24, point.x), size.width - 24),
                y: min(max(24, point.y), size.height - 24))
    }
}

private struct LaundryItemView: View {
    let item: GameState.LaundryItem
    var onFold: () -> Void

    @State private var pressed = false

    var body: some View {
        Button(action: {
            guard !item.isFolding else { return }
            pressed = true
            onFold()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { pressed = false }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.quaternary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.separator.opacity(0.3), lineWidth: 1)
                    )
                Text(item.emoji)
                    .font(.system(size: 40))
                    .rotationEffect(item.angle)
                    .scaleEffect(item.isFolding ? 0.6 : 1.0)
                    .opacity(item.isFolding ? 0.3 : 1.0)
                    .animation(.easeInOut(duration: 0.15), value: item.isFolding)
            }
            .frame(width: 88, height: 88)
        }
        .buttonStyle(.plain)
        .scaleEffect(pressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.12), value: pressed)
        .shadow(radius: 3, y: 2)
    }
}

