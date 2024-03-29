// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @StateObject var appSettings: AppSettings
    @StateObject var arenaScene: ArenaScene

    init() {
        let aa = AppSettings()
        self._appSettings = StateObject(wrappedValue: aa)

        let cc = ArenaSceneModel(appSettings: aa)

        let bb = ArenaScene(sceneModel: cc)
        self._arenaScene = StateObject(wrappedValue: bb)
    }

    var body: some View {
        HStack {
            VStack {
                AppSettingsView()
                SpriteLayerScrollView()
            }
            .frame(
                minWidth: 400, idealWidth: 400, maxWidth: 400,
                minHeight: nil, idealHeight: AppConfig.screenDimensions.height,
                maxHeight: .infinity, alignment: .top
            )

            ArenaView()
        }
        .environmentObject(appSettings)
        .environmentObject(arenaScene)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var appSettings = AppSettings()

    static var previews: some View {
        ContentView().environmentObject(appSettings)
    }
}
