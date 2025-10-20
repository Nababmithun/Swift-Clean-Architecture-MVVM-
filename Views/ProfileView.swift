import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            if let user = auth.user {
                Text(user.name).font(.title2)
                Text(user.email).foregroundColor(.secondary)
            } else {
                Text("No user data").foregroundColor(.secondary)
            }

            Button(action: { auth.logout() }) {
                Text("Logout")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
            }
            .padding(.horizontal)

            Spacer()
        }.padding().navigationTitle("Profile")
    }
}
