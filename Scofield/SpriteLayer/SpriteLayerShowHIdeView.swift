// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteLayerShowHideView: View {
    @StateObject var layer: SpriteLayer

    var body: some View {
        VStack {
            Text("Show / Hide")
                .font(.title3)
                .foregroundColor(Color(NSColor.windowFrameTextColor))
                .padding(.top, -15)
                .padding(.bottom, 5)

            HStack {
                VStack(alignment: .leading) {
                    SpriteLayerToggleView(checked: $layer.showingRingSprite, label: "Ring")
                    SpriteLayerToggleView(checked: $layer.showingCentersSprite, label: "Centers")
                }
                Spacer()
                VStack(alignment: .leading) {
                    SpriteLayerToggleView(checked: $layer.showingRadiusSprite, label: "Radius")
                    SpriteLayerToggleView(checked: $layer.showingPenSprite, label: "Pen")
                }
            }
        }
        .padding([.leading, .trailing], 25)
        .padding(.top, 25)
    }
}

//struct VisibilityView_Previews: PreviewProvider {
//    static var scene = ArenaScene(statics: statics)
//    static var settings = Settings()
//    static var statics = Statics()
//
//    static var previews: some View {
//        VisibilityView(
//            layer: SpriteLayer(
//                settings: settings, scene: scene, statics: statics))
//    }
//}
