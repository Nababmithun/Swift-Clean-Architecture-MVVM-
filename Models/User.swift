import Foundation

// MARK: - User Model
struct User: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let email: String
    let mobile: String?
    let gender: String?
    let isAdmin: Bool
    let avatarUrl: String?
    let createdAt: String?
    let updatedAt: String?

    // Custom Coding Keys to match backend response
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, gender
        case isAdmin = "is_admin"
        case avatarUrl = "avatar_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    // For quick demo init
    init(id: Int = 0, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        self.mobile = nil
        self.gender = nil
        self.isAdmin = false
        self.avatarUrl = nil
        self.createdAt = nil
        self.updatedAt = nil
    }
}

// MARK: - Register Response
struct RegisterResponse: Codable {
    let message: String
    let token: String
    let user: User
}
