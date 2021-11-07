// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

class SpriteLayer: ObservableObject {
    var appSettings: AppSettings
    var arenaScene: ArenaScene

    // Notice that these are kind of secondary variables;
    // the real source of truth is the alpha in an SKSpriteNode that's
    // attached to the SKScene, totally outside SwiftUI's knowledge
    // as far as I can tell.
    @Published var showingRingSprite: Bool = true
    @Published var showingRadiusSprite: Bool = true
    @Published var showingPenSprite: Bool = true
    @Published var showingCentersSprite: Bool = true

    let spacerShape: SKShapeNode!
    let compensator: SKShapeNode
    let penShape: SKShapeNode!
    let penTip: SKShapeNode!
    let ringShape: SKShapeNode!

    let layerIndex: Int

    var inkHue = Double.random(in: 0..<1)

    private func ringRadius() -> CGFloat { ringShape.frame.size.width / 2 }

    // Base ring doesn't do much
    init(appSettings: AppSettings, arenaScene: ArenaScene) {
        self.appSettings = appSettings
        self.arenaScene = arenaScene

        layerIndex = 0

        let rawSceneRadius = AppConfig.screenDimensions.width / 2
        let ringRadius = rawSceneRadius * AppConfig.ringRadiiFractions[0]

        ringShape = SKShapeNode(circleOfRadius: ringRadius)
        ringShape.fillColor = .clear
        ringShape.strokeColor = AppConfig.ringColors[0]

        let sCompensator = CGSize(width: 10, height: 10)
        let oCompensator = CGPoint(x: -5, y: -5)
        let rCompensator = CGRect(origin: oCompensator, size: sCompensator)
        compensator = SKShapeNode(rect: rCompensator)

        compensator.position = .zero
        compensator.fillColor = .clear
        compensator.strokeColor = .clear

        arenaScene.addChild(compensator)
        compensator.addChild(ringShape)

        spacerShape = nil
        penShape = nil
        penTip = nil
    }

    // swiftlint:disable function_body_length
    init(
        appSettings: AppSettings, arenaScene: ArenaScene,
        layerIndex: Int, parentLayer: SpriteLayer
    ) {
        self.appSettings = appSettings
        self.arenaScene = arenaScene
        self.layerIndex = layerIndex

        let fRadius = AppConfig.ringRadiiFractions[layerIndex]
        let mRadius = fRadius * parentLayer.ringRadius()

        var pSpacer: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: mRadius, y: 0)]

        spacerShape = SKShapeNode(points: &pSpacer, count: 2)
        spacerShape.strokeColor = AppConfig.ringColors[layerIndex]

        parentLayer.ringShape.addChild(spacerShape)

        let sCompensator = CGSize(width: 10, height: 10)
        let oCompensator = CGPoint(x: -5, y: -5)
        let rCompensator = CGRect(origin: oCompensator, size: sCompensator)

        compensator = SKShapeNode(rect: rCompensator)
        compensator.position = CGPoint(x: mRadius, y: 0)
        compensator.fillColor = .clear
        compensator.strokeColor = .clear

        spacerShape.addChild(compensator)

        let ringRadius = parentLayer.ringRadius() - mRadius
        ringShape = SKShapeNode(circleOfRadius: ringRadius)
        ringShape.fillColor = .clear
        ringShape.strokeColor = AppConfig.ringColors[layerIndex]

        compensator.addChild(ringShape)

        let penFraction = 1.0//settings.penLengthFraction
        let penLength = ringRadius * penFraction

        var pPen: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: penLength, y: 0)]
        penShape = SKShapeNode(points: &pPen, count: 2)
        penShape.strokeColor = AppConfig.ringColors[layerIndex]
        penShape.zRotation += .tau / 4

        compensator.addChild(penShape)

        penTip = SKShapeNode(circleOfRadius: 2)
        penTip.position = CGPoint(x: penLength, y: 0)
        penTip.strokeColor = .clear

        penShape.addChild(penTip)

        let direction = Double.tau * ((layerIndex % 2 == 0) ? -1.0 : 1.0)
        let ringCycleDuration = 1.0// 1 / settings.rotationRateHz
        let penCycleDuration = ringCycleDuration * (ringRadius / parentLayer.ringRadius())

        let penSpinAction = SKAction.rotate(byAngle: -direction, duration: penCycleDuration)
        let penSpinForever = SKAction.repeatForever(penSpinAction)

        let spinAction = SKAction.rotate(byAngle: direction, duration: ringCycleDuration)
        let spinForever = SKAction.repeatForever(spinAction)

        let compensateAction = SKAction.rotate(byAngle: -direction, duration: ringCycleDuration)
        let compensateForever = SKAction.repeatForever(compensateAction)

        compensator.run(compensateForever)
        penShape.run(penSpinForever)
        spacerShape.run(spinForever)
    }
}
