// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var arenaScene: ArenaScene

    var body: some View {
        Rectangle()
            .opacity(appSettings.initComplete ? 0 : 1)
            .background(Color.blue)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var appSettings = AppSettings()
    static var arenaScene = ArenaScene()

    static var previews: some View {
        SplashView()
            .environmentObject(appSettings)
            .environmentObject(arenaScene)
    }
}
