// Many thanks to https://stackoverflow.com/users/3820660/hello-world
// https://stackoverflow.com/a/63389253/1610473

import SwiftUI

struct SpriteLayerToggleView: View {
    @Binding var checked: Bool

    let label: String

    var body: some View {
        HStack {
            Image(systemName: checked ? "capsule.fill" : "capsule")
                .foregroundColor(checked ? Color(NSColor.systemBlue) : Color.secondary)
                .onTapGesture { self.checked.toggle() }
                .frame(width: 30, alignment: .leading)
                .padding(.trailing, -10)

            Text(label).font(.body)
        }
    }
}

struct SpriteLayerToggleView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false

        var body: some View {
            SpriteLayerToggleView(checked: $checked, label: "Hogwarts")
        }
    }

    static var previews: some View {
        CheckBoxViewHolder()
    }
}
