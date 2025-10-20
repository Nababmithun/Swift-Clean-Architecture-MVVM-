import SwiftUI


struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }
                .tabItem { Label("Home", systemImage: "house") }

           // NavigationStack { HistoryView() }
              // .tabItem { Label("History", systemImage: "clock.arrow.circlepath") }

            NavigationStack { ProfileView() }
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
    }
}

