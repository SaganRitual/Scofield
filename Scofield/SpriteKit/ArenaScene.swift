// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

enum ActionStatus {
    case none, running, finished
}

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    let appSettings: AppSettings
    let dotsPool: SpritePool

    let sceneDispatch = SceneDispatch()

    private var tickCount = 0

    var readyToRun = false
    var actionStatus = ActionStatus.none

    init(appSettings: AppSettings) {
        self.appSettings = appSettings
        self.dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)

        let size = AppConfig.screenDimensions * 0.75
        super.init(size: size)
        print("ArenaScene \(size)")

        self.scaleMode = .aspectFill

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        self.speed = appSettings.simulationSpeed

        view.showsFPS = true
        view.showsNodeCount = true

        backgroundColor = .black

        let startActions = SKAction.run { [self] in
            actionStatus = .running
            readyToRun = true
        }

        self.run(startActions)
    }

    var rotationAngle = 0.0

    override func update(_ currentTime: TimeInterval) {
        defer { Display.displayCycle = .evaluatingActions }
        Display.displayCycle = .updateStarted

        guard readyToRun else { return }

        rotationAngle = 1.5 * sin(0.75 * Double.tau * Double(tickCount % 60) / 60.0) - 0.75 * sin(1.5 * Double.tau * Double(tickCount % 60) / 60.0)
        self.appSettings.layers[0].ringShape.zRotation += (1 + Double.random(in: -0.01...0.01)) * rotationAngle * .tau / (60 * 3)

        self.children[0].setScale(appSettings.zoomLevel)

        // We used to be able to set these flags in didMove(to: View), but
        // after I upgraded to Monterey, they didn't show up in the view any
        // more. Might not be because of Monterey, but atm I don't give a shit,
        // I just wanted to verify that everything isn't broken all to hell.
        if view!.showsFPS == false {
            view!.showsFPS = true
            view!.showsNodeCount = true
        }

        sceneDispatch.tick(tickCount)

        tickCount += 1
    }

    override func didEvaluateActions() {
        defer { Display.displayCycle = .simulatingPhysics }
        Display.displayCycle = .didEvaluateActions

        if actionStatus == .none { return }

        let hue = Double(tickCount % 600) / 600
        let color = NSColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)

        for ix in 1..<appSettings.layers.count {
            let easyDot = dotsPool.makeSprite()
            easyDot.size = CGSize(width: 5, height: 5)
            easyDot.color = color
            easyDot.alpha = 0.85

            let penTip = appSettings.layers[ix].penTip!
            let dotPosition = appSettings.layers[ix].penShape.convert(penTip.position, to: self)

            easyDot.position = dotPosition
            self.addChild(easyDot)

            let pathFadeDurationSeconds = AppConfig.pathFadeDurationSeconds * self.speed
            let fade = SKAction.fadeOut(withDuration: pathFadeDurationSeconds)
            easyDot.run(fade) {
                self.dotsPool.releaseSprite(easyDot)
            }
        }

        if actionStatus == .finished { actionStatus = .none }
    }
}
