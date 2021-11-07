// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AppSettingsSliderView: View {
    @EnvironmentObject var appSettings: AppSettings

    let label: String

    @State var projectedValue: Double
    let range: ClosedRange<Double>

    init(label: String, value: Double, in range: ClosedRange<Double>) {
        self.label = label
        self.projectedValue = value
        self.range = range
    }

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 150, height: nil, alignment: .leading)
                .padding(.leading)

            Slider(
                value: $projectedValue,
                in: range
            ) {
                _ in appSettings.zoomLevel = projectedValue
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
        AppSettingsSliderView(label: "Zoom", value: appSettings.zoomLevel, in: 0...10)
            .environmentObject(appSettings)
    }
}
