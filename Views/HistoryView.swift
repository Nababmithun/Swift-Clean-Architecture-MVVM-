import SwiftUI

struct HistoryView: View {
    VStack {
        Text("History").font(.title)
        Text("Replace with your UI").foregroundColor(.secondary)
        Spacer()
    }.padding().navigationTitle("History")
}
}Preview {
    HistoryView()
}
