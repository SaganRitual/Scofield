// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack(alignment: .leading) {
            AppSettingsSliderView(label: "Base rotation Hz", projectedValue: appSettings.baseRotationRateHz)
            AppSettingsSliderView(label: "Simulation speed", projectedValue: appSettings.simulationSpeed)
            AppSettingsSliderView(label: "Zoom", projectedValue: appSettings.zoomLevel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var appSettings = AppSettings()

    static var previews: some View {
        ContentView().environmentObject(appSettings)
    }
}
