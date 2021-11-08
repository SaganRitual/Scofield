// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit

struct AppConfig {
    static let pathFadeDurationSeconds = CGFloat(5)
    static let ringColors: [NSColor] = [
        NSColor(calibratedWhite: 0.2, alpha: 0.5),
        NSColor(calibratedWhite: 0.2, alpha: 0.4),
        NSColor(calibratedWhite: 0.2, alpha: 0.3),
        NSColor(calibratedWhite: 0.2, alpha: 0.2)
    ]

    static let ringLineWidth = CGFloat(0.1)
    static let ringRadiiFractions = [0.95, 0.2, 0.25, 0.4]
    static let rotationRateHz: Double = 0
    static let simulationSpeed: Double = 0.25
    static let zoomLevel = 1.0

    static var screenDimensions_ = CGSize.zero

    static var screenDimensions: CGSize {
        guard let mainScreen = NSScreen.main else {
            preconditionFailure("You're gonna have a bad day")
        }

        if mainScreen.visibleFrame.size != screenDimensions_ {
            print("ContentView mainScreen \(mainScreen.frame.size), visibleFrame \(mainScreen.visibleFrame.size)")
            screenDimensions_ = mainScreen.visibleFrame.size
        }

        return screenDimensions_
    }
}
