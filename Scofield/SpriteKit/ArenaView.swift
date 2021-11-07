// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ArenaView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var arenaScene: ArenaScene

    var body: some View {
        SpriteView(scene: arenaScene)
            .padding(5)
            .frame(
                minWidth: 400,
                idealWidth: AppConfig.screenDimensions.height,
                maxWidth: AppConfig.screenDimensions.height,
                minHeight: 400,
                idealHeight: AppConfig.screenDimensions.height,
                maxHeight: AppConfig.screenDimensions.height,
                alignment: .leading
            )
    }
}

struct ArenaView_Previews: PreviewProvider {
    static var previews: some View {
        ArenaView()
    }
}
