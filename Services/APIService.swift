import Foundation

enum APIError: LocalizedError, Equatable {
    case invalidResponse
    case requestFailed(String)
    case decodingError
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid server response."
        case .requestFailed(let message): return message
        case .decodingError: return "Unable to decode response."
        case .unknown: return "Unknown error occurred."
        }
    }
}

final class APIService {
    static let shared = APIService()
    private init() {}

    func register(name: String, email: String, password: String, completion: @escaping (Result<User, APIError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.Endpoints.register
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidResponse))
            return
        }

        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(.requestFailed("Invalid request body")))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            // Accept 200-299 as success. If backend returns 201, etc. it's okay.
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    completion(.success(decoded.user))
                } catch {
                    // Try to decode error message if any
                    completion(.failure(.decodingError))
                }
            } else {
                // Try to decode server message if available
                if let msg = String(data: data, encoding: .utf8) {
                    completion(.failure(.requestFailed("Server returned \(httpResponse.statusCode): \(msg)")))
                } else {
                    completion(.failure(.invalidResponse))
                }
            }
        }.resume()
    }

    // temporary demo login (you can implement real endpoint similarly)
    func login(email: String, password: String, completion: @escaping (Result<User, APIError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if email.lowercased() == "demo@example.com" && password == "123456" {
                completion(.success(User(name: "Demo User", email: email)))
            } else {
                completion(.failure(.requestFailed("Invalid credentials")))
            }
        }
    }
}
