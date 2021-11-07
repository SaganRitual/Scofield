// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack(alignment: .leading) {
            AppSettingsSliderView(
                label: "Base rotation Hz", value: appSettings.baseRotationRateHz, in: -2...2
            )

            AppSettingsSliderView(
                label: "Simulation speed", value: appSettings.simulationSpeed, in: 0...5
            )
            AppSettingsSliderView(
                label: "Zoom", value: appSettings.zoomLevel, in: 0...5
            )
        }
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static let appSettings = AppSettings()

    static var previews: some View {
        AppSettingsView().environmentObject(appSettings)
    }
}
