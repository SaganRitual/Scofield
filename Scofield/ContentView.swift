// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    @State var appSettings = AppSettings()
    @State var arenaScene = ArenaScene()

    var body: some View {
        ZStack {
            HStack {
                AppSettingsView(appSettings: appSettings)

                SpriteView(scene: arenaScene)
                    .padding(5)
                    .frame(
                        minWidth: 400, idealWidth: nil,
                        maxWidth: AppConfig.screenDimensions.height,
                        minHeight: 400, idealHeight: nil,
                        maxHeight: AppConfig.screenDimensions.height,
                        alignment: .leading
                    )
            }

            SplashView()
                .environmentObject(appSettings)
                .environmentObject(arenaScene)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var appSettings = AppSettings()
    static var arenaScene = ArenaScene()

    static var previews: some View {
        ContentView()
    }
}
