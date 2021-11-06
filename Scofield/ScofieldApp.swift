// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

@main
struct ScofieldApp: App {
    var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appSettings)
        }
    }
}
