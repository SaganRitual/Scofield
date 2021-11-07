// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ArenaView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        SpriteView(scene: ArenaScene(appSettings: appSettings))
            .padding(5)
            .frame(
                minWidth: 400, idealWidth: nil,
                maxWidth: AppConfig.screenDimensions.height,
                minHeight: 400, idealHeight: nil,
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
