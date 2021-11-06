// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

class AppSettings: ObservableObject {
    @Published var baseRotationRateHz = AppConfig.rotationRateHz
    @Published var simulationSpeed = AppConfig.simulationSpeed
    @Published var zoomLevel = AppConfig.zoomLevel

    @Published var initComplete = false
}
