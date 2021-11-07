// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class ArenaSceneModel {
    let appSettings: AppSettings
    let dotsPool: SpritePool

    var rotationAngle = 0.0

    let sceneDispatch = SceneDispatch()

    var tickCount = 0

    var readyToRun = false
    var actionStatus = ActionStatus.none

    init(appSettings: AppSettings) {
        self.appSettings = appSettings
        self.dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)
    }
}
