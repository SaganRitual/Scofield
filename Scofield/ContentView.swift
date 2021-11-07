// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        HStack {
            AppSettingsView()
            ArenaView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var appSettings = AppSettings()

    static var previews: some View {
        ContentView().environmentObject(appSettings)
    }
}
