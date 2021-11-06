// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var appSettings: AppSettings

    let label: String

    var body: some View {
        Text("AppSettingsView")
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView(label: "Simulation speed")
            .environmentObject(AppSettings())
    }
}
