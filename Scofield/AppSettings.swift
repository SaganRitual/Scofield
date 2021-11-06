// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

class AppSettings: ObservableObject {
    @Published var baseRotationRateHz = 1.0
    @Published var simulationSpeed = 2.0
    @Published var zoomLevel = 3.0

    let lineWidth = CGFloat(1)
    let pathFadeDuration = CGFloat(5)
}
