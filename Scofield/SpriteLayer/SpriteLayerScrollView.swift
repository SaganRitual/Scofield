// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteLayerScrollView: View {
    @EnvironmentObject var scene: ArenaScene

    @State var layers = [SpriteLayer]()

    func getLayer(layerIndex: Int) -> SpriteLayer {
        if layerIndex < layers.count {
            let layer = layerIndex == 0 ?
            SpriteLayer(scene: scene) :
            SpriteLayer(layerIndex: layerIndex, parentLayer: layers[layerIndex - 1])

            layers.append(layer)
        }

        return layers.last!
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<layers.count) {
                    SpriteLayerView(layer: getLayer(layerIndex: $0))
                }
            }
        }
    }
}

struct SpriteLayerScrollview_Previews: PreviewProvider {
    static var previews: some View {
        SpriteLayerScrollView()
    }
}
