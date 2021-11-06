// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings

    let scene = ArenaScene()

    var body: some View {
        ZStack {
            HStack {
                AppSettingsView()
                SpriteView(scene: scene)
                    .padding(5)
                    .frame(
                        minWidth: 400, idealWidth: nil,
                        maxWidth: AppConfig.screenDimensions.height,
                        minHeight: 400, idealHeight: nil,
                        maxHeight: AppConfig.screenDimensions.height,
                        alignment: .leading
                )
            }

            Rectangle()
                .opacity(appSettings.initComplete ? 0 : 1)
                .background(Color.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var appSettings = AppSettings()

    static var previews: some View {
        ContentView().environmentObject(appSettings)
    }
}
