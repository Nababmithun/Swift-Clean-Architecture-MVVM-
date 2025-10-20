import SwiftUI
import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let api = APIService.shared

    func register(name: String, email: String, password: String) {
        isLoading = true
        errorMessage = nil
        api.register(name: name, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func login(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        api.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func logout() {
        user = nil
        isAuthenticated = false
    }
}
