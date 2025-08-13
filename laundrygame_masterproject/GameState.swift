//
//  GameState.swift
//  laundrygame_masterproject
//
//  Rudimentary game state and loop for a Fruit Ninja–style
//  laundry folding game. Focused on UI/game flow scaffolding.
//

import SwiftUI

@MainActor
@Observable
class GameState {
    enum Phase { case menu, playing, paused, results }

    struct LaundryItem: Identifiable, Equatable {
        enum Kind: CaseIterable { case shirt, socks, pants, towel }

        let id = UUID()
        let kind: Kind
        var position: CGPoint
        var angle: Angle
        var isFolding: Bool = false

        var emoji: String {
            switch kind {
            case .shirt: return "👕"
            case .socks: return "🧦"
            case .pants: return "🩳"
            case .towel: return "🧺"
            }
        }
    }

    // Game progression
    var phase: Phase = .menu
    var score: Int = 0
    var timeRemaining: Int = 60
    var combo: Int = 0
    var bestScore: Int = 0

    // Active items
    var items: [LaundryItem] = []

    // Loop
    private var loopTask: Task<Void, Never>? = nil

    func startGame() {
        score = 0
        combo = 0
        timeRemaining = 60
        items.removeAll()
        phase = .playing
        startLoop()
    }

    func pauseGame() {
        guard phase == .playing else { return }
        phase = .paused
        loopTask?.cancel()
        loopTask = nil
    }

    func resumeGame() {
        guard phase == .paused else { return }
        phase = .playing
        startLoop()
    }

    func endGame() {
        phase = .results
        bestScore = max(bestScore, score)
        loopTask?.cancel()
        loopTask = nil
    }

    func quitToMenu() {
        loopTask?.cancel()
        loopTask = nil
        items.removeAll()
        phase = .menu
    }

    func fold(item: LaundryItem) {
        guard let idx = items.firstIndex(of: item), phase == .playing else { return }
        // Mark folding for a quick visual response
        items[idx].isFolding = true
        score += 10
        combo += 1

        // Remove after a short delay to allow animation
        Task { [weak self] in
            try? await Task.sleep(nanoseconds: 150_000_000)
            await self?.removeItem(id: item.id)
        }
    }

    private func removeItem(id: UUID) {
        items.removeAll { $0.id == id }
    }

    private func startLoop() {
        loopTask?.cancel()
        loopTask = Task { [weak self] in
            guard let self else { return }
            while !Task.isCancelled, self.phase == .playing {
                // Tick every 1s
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                guard !Task.isCancelled, self.phase == .playing else { break }

                // Decrement timer
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
                if self.timeRemaining == 0 {
                    self.endGame()
                    break
                }

                // Spawn 1–3 items
                let spawnCount = Int.random(in: 1...2)
                for _ in 0..<spawnCount { self.spawnItem(inset: 24) }

                // Decay combo over time
                self.combo = max(0, self.combo - 1)
            }
        }
    }

    private func spawnItem(inset: CGFloat) {
        // Spawn with a random type and position; layout happens in view space
        let kind = LaundryItem.Kind.allCases.randomElement() ?? .shirt
        let x = CGFloat.random(in: inset...(800 - inset))
        let y = CGFloat.random(in: inset...(500 - inset))
        let angle = Angle.degrees(Double.random(in: -12...12))
        let item = LaundryItem(kind: kind, position: CGPoint(x: x, y: y), angle: angle)
        items.append(item)
    }
}

