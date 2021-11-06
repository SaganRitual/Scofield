// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

enum ActionStatus {
    case none, running, finished
}

protocol ArenaSceneSeat {
    func sceneIsReady() -> Bool
}

class DummyArena: ArenaSceneSeat {
    func sceneIsReady() -> Bool { false }
}

extension ArenaScene: ArenaSceneSeat {
    func sceneIsReady() -> Bool { true }
}

var arenaScene = DummyArena()

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    @EnvironmentObject var settings: AppSettings

    let dotsPool: SpritePool

    let sceneDispatch = SceneDispatch()

    private var tickCount = 0

    var readyToRun = false
    var actionStatus = ActionStatus.none

    override init() {
        self.dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)

        super.init(size: AppConfig.screenDimensions * 0.75)

        self.scaleMode = .aspectFill

        print("ArenaScene \(size)")

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
//        self.speed = settings.simulationSpeed

        view.showsFPS = true
        view.showsNodeCount = true

        backgroundColor = NSColor.windowBackgroundColor


        let startActions = SKAction.run { [self] in
            actionStatus = .running
            readyToRun = true
            settings.initComplete = true
        }
        self.run(startActions)
    }

    override func update(_ currentTime: TimeInterval) {
        defer { Display.displayCycle = .evaluatingActions }
        Display.displayCycle = .updateStarted

        guard readyToRun else { return }
//
//        // We used to be able to set these flags in didMove(to: View), but
//        // after I upgraded to Monterey, they didn't show up in the view any
//        // more. Might not be because of Monterey, but atm I don't give a shit,
//        // I just wanted to verify that everything isn't broken all to hell.
//        if view!.showsFPS == false {
//            view!.showsFPS = true
//            view!.showsNodeCount = true
//        }

        sceneDispatch.tick(tickCount)

        tickCount += 1
    }
}
