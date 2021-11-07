// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteLayerScrollView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var arenaScene: ArenaScene

    func getLayer(layerIndex: Int) -> SpriteLayer {
        if layerIndex <= appSettings.layers.count {
            let layer = layerIndex == 0 ?
            SpriteLayer(appSettings: appSettings, arenaScene: arenaScene) :
            SpriteLayer(
                appSettings: appSettings, arenaScene: arenaScene,
                layerIndex: layerIndex,
                parentLayer: appSettings.layers[layerIndex - 1]
            )

            appSettings.layers.append(layer)
        }

        return appSettings.layers.last!
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<appSettings.cLayers) {
                    SpriteLayerView(layer: getLayer(layerIndex: $0))
                }
            }
        }
    }
}
//
//struct SpriteLayerScrollview_Previews: PreviewProvider {
//    static var previews: some View {
//        SpriteLayerScrollView()
//    }
//}
