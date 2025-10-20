import SwiftUI
import Foundation


struct ContentView: View {
    @EnvironmentObject var auth: AuthViewModel  // ✅ Get from environment

    var body: some View {
        Group {
            if auth.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
