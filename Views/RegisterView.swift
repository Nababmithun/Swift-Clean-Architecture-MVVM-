import SwiftUI
import Foundation


struct RegisterView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("Name", text: $name)
                    .padding().background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
                    .disabled(auth.isLoading)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding().background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
                    .disabled(auth.isLoading)

                SecureField("Password", text: $password)
                    .padding().background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
                    .disabled(auth.isLoading)

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding().background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
                    .disabled(auth.isLoading)

                if let err = auth.errorMessage {
                    Text(err).foregroundColor(.red).multilineTextAlignment(.center)
                }

                Button(action: {
                    let n = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let e = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !n.isEmpty && !e.isEmpty && !password.isEmpty else {
                        auth.errorMessage = "Please fill all fields"
                        return
                    }
                    guard password == confirmPassword else {
                        auth.errorMessage = "Passwords do not match"
                        return
                    }

                    auth.register(name: n, email: e, password: password)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if auth.isAuthenticated { dismiss() }
                    }
                }) {
                    HStack { Spacer()
                        if auth.isLoading { ProgressView() } else { Text("Register").bold() }
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.accentColor))
                    .foregroundColor(.white)
                }
                .disabled(auth.isLoading)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Register")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
