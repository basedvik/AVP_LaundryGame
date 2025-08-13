Laundry Ninja (visionOS)

Overview
- Minimal visionOS SwiftUI app scaffolding a Fruit Ninja–style laundry folding game.
- Focuses on UI and game flow only (menu → gameplay → pause → results). No custom vision pipeline.

How to Run
- Open `laundrygame_masterproject.xcodeproj` in Xcode 16+ with visionOS 2 SDK.
- Select the visionOS Simulator (or a device) and run.
 - If you don’t see new files in the target, open the project navigator; with File System–Synced Groups they should appear automatically under `laundrygame_masterproject/`. Build once to let Xcode sync.

Gameplay Flow
- Main Menu: Tap “Start Game” to begin.
- Gameplay: Tap floating laundry tiles to “fold” and score points. Timer counts down from 60s.
- HUD: Shows score and timer; Pause button opens overlay.
- Pause: Resume or Quit to the main menu.
- Results: Shows score and best score; Play Again or return to Menu.

Key Files
- `laundrygame_masterproject/GameState.swift`: Game state, loop, item spawning, scoring.
- `laundrygame_masterproject/ContentView.swift`: Scene router for phases.
- `laundrygame_masterproject/views/*`: UI for menu, gameplay, HUD, pause, and results.
- Existing `Renderer.swift` + shaders remain for immersive experiments; not required for core flow.

Next Steps
- Add simple physics/trajectories for items.
- Add gesture-based “fold” mechanics (e.g., pinch or slice).
- Integrate object detection to spawn/score real laundry items.
