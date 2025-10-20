//
//  APIConstants.swift
//  MVVM-IOS-Project-Swift
//
//  Created by Second Source on 10/20/25.
//

import Foundation


struct APIConstants {
    static let baseURL = "https://task-manager.peopleplusbd.com/api"

    struct Endpoints {
        static let register = "/register"
        static let login = "/login"
        static let logout = "/logout"
        static let profile = "/profile"
    }
}
