//
//  MVVM_IOS_Project_SwiftApp.swift
//  MVVM-IOS-Project-Swift
//
//  Created by Second Source on 10/20/25.
//

import SwiftUI

@main
struct MVVM_IOS_Project_SwiftApp: App {
    @StateObject private var auth = AuthViewModel()  // ✅ Create instance here

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)             // ✅ Inject into environment
        }
    }
}
