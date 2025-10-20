import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home").font(.title)
            Text("Replace with your UI").foregroundColor(.secondary)
            Spacer()
        }.padding().navigationTitle("Home")
    }
}
