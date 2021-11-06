// We are a way for the cosmos to know itself. -- C. Sagan

//import SwiftUI

//struct SpriteLayerView: View {
//    @StateObject var layer: SpriteLayer
//    @StateObject var parentLayer: SpriteLayer
//
//    init(scene: ArenaScene) {
//        let sl = SpriteLayer(scene: scene)
//
//        _layer = StateObject(wrappedValue: sl)
//    }
//
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct SpriteLayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpriteLayerView(scene: ArenaScene())
//    }
//}
//
// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteLayerView: View {
    var layer: SpriteLayer

    init(layer: SpriteLayer) {
        self.layer = layer
    }

    var body: some View {
        SpriteLayerShowHideView(layer: layer)
            .frame(width: 300)
            .frame(maxHeight: .infinity)
    }
}

//struct SpriteLayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpriteLayerView()
//    }
//}
