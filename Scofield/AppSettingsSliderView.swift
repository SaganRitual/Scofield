// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AppSettingsSliderView: View {
    @EnvironmentObject var appSettings: AppSettings

    let label: String

    @State var projectedValue: Double

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 150, height: nil, alignment: .leading)
                .padding(.leading)

            Slider(
                value: $projectedValue,
                in: 0...10
            ) { isEditing in
                if isEditing { print("Changing sim speed") }
                else         { print("Simulation speed", projectedValue) }
            }
                .padding(.trailing, 10)

            Text("\(projectedValue.asString(decimals: 2))")
                .padding(.trailing, 10)
        }
    }
}

struct AppSettingsSliderView_Previews: PreviewProvider {
    static var appSettings = AppSettings()

    static var previews: some View {
        AppSettingsSliderView(label: "Zoom", projectedValue: appSettings.zoomLevel)
            .environmentObject(appSettings)
    }
}
