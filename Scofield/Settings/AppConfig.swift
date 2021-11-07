// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit

struct AppConfig {
    static let pathFadeDurationSeconds = CGFloat(5)
    static let ringColors: [NSColor] = [.cyan, .magenta, .yellow, .green]
    static let ringLineWidth = CGFloat(0.1)
    static let ringRadiiFractions = [0.95, 0.2, 0.2, 0.2]
    static let rotationRateHz: Double = 1.00
    static let simulationSpeed: Double = 0.25
    static let zoomLevel = 0.0

    static var screenDimensions: CGSize = {
        guard let mainScreen = NSScreen.main else {
            preconditionFailure("You're gonna have a bad day")
        }

        print("ContentView says screen visible is CGSize(width: \(mainScreen.visibleFrame.size))")
        return mainScreen.visibleFrame.size
    }()
}
