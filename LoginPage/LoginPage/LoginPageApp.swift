//
//  LoginPageApp.swift
//  LoginPage
//
//  Created by gavin ward on 10/8/26.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct LoginPageApp: App {
    @StateObject private var auth = AuthService()

    init() {
        if Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil {
            FirebaseApp.configure()
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
