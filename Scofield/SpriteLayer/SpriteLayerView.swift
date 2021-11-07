// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteLayerView: View {
    @StateObject var layer: SpriteLayer
//    @ObservedObject var parentLayer: SpriteLayer

    init(layer: SpriteLayer) {
        _layer = StateObject(wrappedValue: layer)
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct SpriteLayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpriteLayerView(scene: ArenaScene())
//    }
//}
