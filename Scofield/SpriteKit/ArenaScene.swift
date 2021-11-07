// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

enum ActionStatus {
    case none, running, finished
}

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    let sceneModel: ArenaSceneModel

    init(sceneModel: ArenaSceneModel) {
        self.sceneModel = sceneModel
        super.init(size: AppConfig.screenDimensions * 0.75)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        // aspectFit scales the scene such that it always fits inside the
        // view, letterboxing the scene if necessary
        self.scaleMode = .aspectFit

        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        self.speed = sceneModel.appSettings.simulationSpeed

        view.showsFPS = true
        view.showsNodeCount = true

        backgroundColor = .darkGray

        let startActions = SKAction.run { [self] in
            sceneModel.actionStatus = .running
            sceneModel.readyToRun = true
        }

        self.run(startActions)
    }

    override func update(_ currentTime: TimeInterval) {
        defer { Display.displayCycle = .evaluatingActions }
        Display.displayCycle = .updateStarted

        guard sceneModel.readyToRun else { return }

        self.children[0].setScale(1.0 / sceneModel.appSettings.zoomLevel)

        // We used to be able to set these flags in didMove(to: View), but
        // after I upgraded to Monterey, they didn't show up in the view any
        // more. Might not be because of Monterey, but atm I don't give a shit,
        // I just wanted to verify that everything isn't broken all to hell.
        if view!.showsFPS == false {
            view!.showsFPS = true
            view!.showsNodeCount = true
        }

        sceneModel.sceneDispatch.tick(sceneModel.tickCount)

        sceneModel.tickCount += 1
    }

    override func didEvaluateActions() {
        defer { Display.displayCycle = .simulatingPhysics }
        Display.displayCycle = .didEvaluateActions

        if sceneModel.actionStatus == .none { return }

        let hue = Double(sceneModel.tickCount % 600) / 600
        let color = NSColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)

        for ix in 1..<sceneModel.appSettings.layers.count {
            let easyDot = sceneModel.dotsPool.makeSprite()
            easyDot.size = CGSize(width: 5, height: 5)
            easyDot.color = color
            easyDot.alpha = 0.85

            let penTip = sceneModel.appSettings.layers[ix].penTip!
            let dotPosition = sceneModel.appSettings.layers[ix].penShape.convert(penTip.position, to: self)

            easyDot.position = dotPosition
            self.addChild(easyDot)

            let pathFadeDurationSeconds = AppConfig.pathFadeDurationSeconds * self.speed
            let fade = SKAction.fadeOut(withDuration: pathFadeDurationSeconds)
            easyDot.run(fade) {
                self.sceneModel.dotsPool.releaseSprite(easyDot)
            }
        }

        if sceneModel.actionStatus == .finished { sceneModel.actionStatus = .none }
    }
}
