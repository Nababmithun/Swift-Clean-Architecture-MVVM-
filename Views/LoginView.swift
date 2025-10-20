import SwiftUI
import Foundation


struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 16).opacity(0.06))
                    Text("Welcome Back")
                        .font(.title2)
                        .bold()
                }

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding().background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
                    .disabled(auth.isLoading)

                SecureField("Password", text: $password)
                    .padding().background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.secondary.opacity(0.22)))
                    .disabled(auth.isLoading)

                if let err = auth.errorMessage {
                    Text(err).foregroundColor(.red).multilineTextAlignment(.center)
                }

                Button(action: {
                    auth.login(email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                               password: password)
                }) {
                    HStack { Spacer()
                        if auth.isLoading { ProgressView() } else { Text("Login").bold() }
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.accentColor))
                    .foregroundColor(.white)
                }
                .disabled(auth.isLoading)
                .padding(.horizontal)

                HStack {
                    Rectangle().frame(height: 1).opacity(0.12)
                    Text("OR").font(.caption).foregroundColor(.secondary)
                    Rectangle().frame(height: 1).opacity(0.12)
                }.padding(.horizontal)

                HStack {
                    Text("Don't have an account?").foregroundColor(.secondary)
                    Button(action: { showRegister = true }) { Text("Create account").bold() }
                        .disabled(auth.isLoading)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .sheet(isPresented: $showRegister) {
                RegisterView().environmentObject(auth)
            }
        }
    }
}
